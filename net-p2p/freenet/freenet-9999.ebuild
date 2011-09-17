# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-9999.ebuild,v 1.23 2011/09/17 18:42:44 tommy Exp $

EAPI="2"
DATE=20110917
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="git://github.com/freenet/fred-official.git"
EGIT_PROJECT="freenet/fred-official"

inherit eutils git-2 java-pkg-2 java-ant-2 multilib

DESCRIPTION="An encrypted network without censorship"
HOMEPAGE="http://www.freenetproject.org/"
SRC_URI="mirror://gentoo/seednodes-${DATE}.fref.bz2
	mirror://gentoo/freenet-ant-1.7.1.jar"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="freemail test"

CDEPEND="freemail? ( dev-java/bcprov )
	dev-java/commons-compress
	dev-db/db-je:3.3
	dev-java/fec
	dev-java/java-service-wrapper
	dev-java/db4o-jdk11
	dev-java/db4o-jdk12
	dev-java/db4o-jdk5
	dev-java/jbitcollider-core
	dev-java/lzma
	dev-java/lzmajio
	dev-java/mersennetwister"
DEPEND=">=virtual/jdk-1.6
	${CDEPEND}
	test? ( dev-java/junit )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.6
	net-libs/nativebiginteger
	${CDEPEND}"
PDEPEND="net-libs/NativeThread"
S=${WORKDIR}/${PN}

EANT_BUILD_TARGET="package"
EANT_BUILD_XML="build-clean.xml"
EANT_GENTOO_CLASSPATH="commons-compres db4o-jdk5 db4o-jdk12 db4o-jdk11 db-je-3.3 fec java-service-wrapper jbitcollider-core lzma lzmajio mersennetwister"
EANT_EXTRA_ARGS="-Dsuppress.gjs=true -Dlib.contrib.present=true -Dlib.junit.present=true"
use test || export EANT_EXTRA_ARGS+=" -Dtest.skip=true"
use test && EANT_GENTOO_CLASSPATH+=" junit"

pkg_setup() {
	has_version dev-java/icedtea[cacao] && {
		ewarn "dev-java/icedtea was built with cacao USE flag."
		ewarn "freenet may compile with it, but it will refuse to run."
		ewarn "Please remerge dev-java/icedtea without cacao USE flag,"
		ewarn "if you plan to use it for running freenet."
	}
	java-pkg-2_pkg_setup
	enewgroup freenet
	enewuser freenet -1 -1 /var/freenet freenet
}

src_unpack() {
	unpack seednodes-${DATE}.fref.bz2
	git_src_unpack
}

src_prepare() {
	cp "${FILESDIR}"/freenet-0.7.5_p1389-wrapper1.conf freenet-wrapper.conf || die
	cp "${FILESDIR}"/run.sh-20090501 run.sh || die
	epatch "${FILESDIR}"/0.7.5_p1302-ext.patch \
		"${FILESDIR}"/freenet-0.7.5_p1384-libraryloader-just-try-loading.patch \
		"${FILESDIR}"/freenet-0.7.5_p1384-nativebiginteger-no-nativedoublevalue.patch
	sed -i -e "s:=/usr/lib:=/usr/$(get_libdir):g" \
		freenet-wrapper.conf || die "sed failed"

	echo "wrapper.java.classpath.1=/usr/share/freenet/lib/freenet.jar" >> freenet-wrapper.conf

	local i=2 pkg jars jar
	for pkg in ${EANT_GENTOO_CLASSPATH} ; do
		jars="$(java-pkg_getjars ${pkg})"
		for jar in ${jars} ; do
			echo "wrapper.java.classpath.$((i++))=${jar}" >> freenet-wrapper.conf
		done
	done
	echo "wrapper.java.classpath.$((i++))=/usr/share/freenet/lib/ant.jar" >> freenet-wrapper.conf

	if use freemail ; then
		jars="$(java-pkg_getjars bcprov)"
		for jar in ${jars} ; do
			echo "wrapper.java.classpath.$((i++))=${jar}" >> freenet-wrapper.conf
		done
	fi

	java-ant_rewrite-classpath "${EANT_BUILD_XML}"
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar dist/freenet.jar
	java-pkg_newjar "${DISTDIR}"/freenet-ant-1.7.1.jar ant.jar
	if has_version =sys-apps/baselayout-2*; then
		doinitd "${FILESDIR}"/freenet
	else
		newinitd "${FILESDIR}"/freenet.old freenet
	fi
	dodoc AUTHORS README || die
	insinto /etc
	doins freenet-wrapper.conf || die
	insinto /var/freenet
	doins run.sh || die
	newins "${WORKDIR}"/seednodes-${DATE}.fref seednodes.fref || die
	fperms +x /var/freenet/run.sh
	dosym java-service-wrapper/libwrapper.so /usr/$(get_libdir)/libwrapper.so
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src
}

pkg_postinst() {
	elog " "
	elog "1. Start freenet with /etc/init.d/freenet start."
	elog "2. Open localhost:8888 in your browser for the web interface."
	#workaround for previously existing freenet user
	[[ $(stat --format="%U" /var/freenet) == "freenet" ]] || chown \
		freenet:freenet /var/freenet
}

pkg_postrm() {
	if ! [[ -e /usr/share/freenet/lib/freenet.jar ]] ; then
		elog " "
		elog "If you dont want to use freenet any more"
		elog "and dont want to keep your identity/other stuff"
		elog "remember to do 'rm -rf /var/freenet' to remove everything"
	fi
}
