# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/rxtx/rxtx-2.1.7.2.ebuild,v 1.2 2007/01/05 23:35:56 caster Exp $

inherit autotools java-pkg-2

MY_PV="2.1-7r2"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Native lib providing serial and parallel communication for Java"
HOMEPAGE="http://rxtx.org/"
SRC_URI="ftp://ftp.qbang.org/pub/rxtx/${MY_P}.zip"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~amd64 ~x86"
IUSE="doc source lfd"

RDEPEND=">=virtual/jre-1.4"

DEPEND=">=virtual/jdk-1.4
	${RDEPEND}
	app-arch/unzip
	dev-java/ant-core
	lfd? ( sys-apps/xinetd )
	source? ( app-arch/zip )"

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# some minor fixes
	sed -i -e "s:UTS_RELEASE::g" configure.in
	sed -i -e "s:\(\$(JAVADOC)\):\1 -d apidocs:g" Makefile.am

	# some patches
	epatch "${FILESDIR}/${MY_P}-lfd.diff"
	epatch "${FILESDIR}/${MY_P}-nouts.diff"

	# update autotools stuff
	eautoreconf
	elibtoolize
}

src_compile() {
	local myconf=""
	use lfd && myconf="--enable-lockfile_server"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"

	if use lfd; then
		cd src/lfd
		emake || die "emake lfd failed"
		cd "${S}"
	fi

	use doc && emake docs
}

src_install() {
	java-pkg_dojar RXTXcomm.jar
	java-pkg_doso ${CHOST}/.libs/*.so

	dodoc AUTHORS ChangeLog INSTALL PORTING TODO SerialPortInstructions.txt
	dohtml RMISecurityManager.html

	if use lfd; then
		insinto /etc/xinetd.d
		newsbin src/lfd/lfd in.lfd
		newins "${FILESDIR}/lockfiled.xinetd" lfd
		dodoc src/lfd/LockFileServer.rfc
	fi

	use doc && java-pkg_dohtml -r apidocs/
	use source && java-pkg_dosrc src/.
}

pkg_postinst() {
	elog
	if use lfd; then
		elog "Don't forget to enable the LockFileServer"
		elog "daemon (lfd) in /etc/xinetd.d/lfd"
	else
		elog "RXTX uses UUCP style device-locks. You should"
		elog "add every user who needs to access serial ports"
		elog "to the 'uucp' group:"
		elog
		elog "    usermod -aG uucp <user>"
	fi
	elog
}
