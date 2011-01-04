# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/freenet/freenet-9999.ebuild,v 1.13 2011/01/04 17:02:05 tommy Exp $

EAPI="2"
DATE=20110102
JAVA_PKG_IUSE="doc source"

EGIT_REPO_URI="git://github.com/freenet/fred-official.git"
EGIT_PROJECT="freenet/fred-official"

inherit eutils git java-pkg-2 java-ant-2 multilib

DESCRIPTION="An encrypted network without censorship"
HOMEPAGE="http://www.freenetproject.org/"
SRC_URI="mirror://gentoo/seednodes-${DATE}.fref"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="freemail test"

CDEPEND="dev-db/db-je:3.3
	dev-java/fec
	dev-java/java-service-wrapper
	dev-java/db4o-jdk11
	dev-java/db4o-jdk12
	dev-java/db4o-jdk5
	=dev-java/ant-core-1.7*
	dev-java/lzma
	dev-java/lzmajio
	dev-java/mersennetwister"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}
	test? ( dev-java/junit )"
RDEPEND=">=virtual/jre-1.5
	net-libs/nativebiginteger
	${CDEPEND}"
PDEPEND="net-libs/NativeThread
	freemail? ( dev-java/bcprov )"
S=${WORKDIR}/${PN}

EANT_BUILD_TARGET="package"
EANT_BUILD_XML="build-clean.xml"
EANT_GENTOO_CLASSPATH="ant-core db4o-jdk5 db4o-jdk12 db4o-jdk11 db-je-3.3 fec java-service-wrapper lzma lzmajio mersennetwister"
EANT_EXTRA_ARGS="-Dsuppress.gjs=true -Dlib.contrib.present=true -Dlib.junit.present=true"
use test || export EANT_EXTRA_ARGS+=" -Dtest.skip=true"
use test && EANT_GENTOO_CLASSPATH+=" junit"

pkg_setup() {
	java-pkg-2_pkg_setup
	enewgroup freenet
	enewuser freenet -1 -1 /var/freenet freenet
}

src_prepare() {
	cp "${FILESDIR}"/wrapper1.conf freenet-wrapper.conf || die
	cp "${FILESDIR}"/run.sh-20090501 run.sh || die
	epatch "${FILESDIR}"/{0.7.5_p1302-ext,strip-openjdk-check}.patch
	sed -i -e "s:=/usr/lib:=/usr/$(get_libdir):g" freenet-wrapper.conf || die "sed failed"
	use freemail && echo "wrapper.java.classpath.12=/usr/share/bcprov/lib/bcprov.jar" >> freenet-wrapper.conf
	java-ant_rewrite-classpath "${EANT_BUILD_XML}"
	cp "${DISTDIR}"/seednodes-${DATE}.fref seednodes.fref || die
}

src_install() {
	java-pkg_dojar dist/freenet.jar
	if has_version =sys-apps/baselayout-2*; then
		doinitd "${FILESDIR}"/freenet
	else
		newinitd "${FILESDIR}"/freenet.old freenet
	fi
	dodoc AUTHORS README || die
	insinto /etc
	doins freenet-wrapper.conf || die
	insinto /var/freenet
	doins seednodes.fref run.sh || die
	fperms +x /var/freenet/run.sh
	dosym java-service-wrapper/libwrapper.so /usr/$(get_libdir)/libwrapper.so
	use doc && java-pkg_dojavadoc javadoc
	use source && java-pkg_dosrc src
}

pkg_postinst() {
	elog
	elog "1. Start freenet with /etc/init.d/freenet start."
	elog "2. Open localhost:8888 in your browser for the web interface."
	#workaround for previously existing freenet user
	[[ $(stat --format="%U" /var/freenet) == "freenet" ]] || chown \
		freenet:freenet /var/freenet
}

pkg_postrm() {
	if ! [[ -e /usr/share/freenet/lib/freenet.jar ]] ; then
		elog "If you dont want to use freenet any more"
		elog "and dont want to keep your identity/other stuff"
		elog "remember to do 'rm -rf /var/freenet' to remove everything"
	fi
}
