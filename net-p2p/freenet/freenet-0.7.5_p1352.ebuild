# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-0.7.5_p1352.ebuild,v 1.2 2011/02/15 21:19:42 tommy Exp $

EAPI="2"
DATE=20110212
JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 java-ant-2 multilib

DESCRIPTION="An encrypted network without censorship"
HOMEPAGE="http://www.freenetproject.org/"
SRC_URI="http://github.com/${PN}/fred-official/zipball/build0${PV#*p} -> ${P}.zip
	mirror://gentoo/seednodes-${DATE}.fref.bz2
	mirror://gentoo/freenet-ant-1.7.1.jar"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="freemail test"

CDEPEND="dev-db/db-je:3.3
	dev-java/fec
	dev-java/java-service-wrapper
	dev-java/db4o-jdk11
	dev-java/db4o-jdk12
	dev-java/db4o-jdk5
	dev-java/lzma
	dev-java/lzmajio
	dev-java/mersennetwister"
DEPEND="app-arch/unzip
	>=virtual/jdk-1.5
	${CDEPEND}
	test? ( dev-java/junit )
	dev-java/ant-core"
RDEPEND=">=virtual/jre-1.5
	net-libs/nativebiginteger
	${CDEPEND}"
PDEPEND="net-libs/NativeThread
	freemail? ( dev-java/bcprov )"

EANT_BUILD_TARGET="package"
EANT_BUILD_XML="build-clean.xml"
EANT_GENTOO_CLASSPATH="ant-core db4o-jdk5 db4o-jdk12 db4o-jdk11 db-je-3.3 fec java-service-wrapper lzma lzmajio mersennetwister"
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
	unpack ${P}.zip seednodes-${DATE}.fref.bz2
}

src_prepare() {
	mv "${WORKDIR}"/freenet-fred-* "${S}"
	cd "${S}"
	cp "${FILESDIR}"/wrapper1.conf freenet-wrapper.conf || die
	cp "${FILESDIR}"/run.sh-20090501 run.sh || die
	epatch "${FILESDIR}"/0.7.5_p1302-ext.patch
	epatch "${FILESDIR}"/strip-openjdk-check.patch
	sed -i -e "s:=/usr/lib:=/usr/$(get_libdir):g" \
		-e "s:/usr/share/ant-core/lib/ant.jar:/usr/share/freenet/lib/ant.jar:g" \
		freenet-wrapper.conf || die "sed failed"
	use freemail && echo "wrapper.java.classpath.12=/usr/share/bcprov/lib/bcprov.jar" >> freenet-wrapper.conf
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
