# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcdplay/wmcdplay-1.0_beta1.ebuild,v 1.4 2006/01/24 22:34:10 nelchael Exp $

inherit eutils

IUSE=""

MY_P=${P/_beta/-beta}
S=${WORKDIR}/${PN}

DESCRIPTION="CD player applet for WindowMaker"
SRC_URI="http://www.geocities.com/SiliconValley/Vista/2471/files/${MY_P}.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/Vista/2471/"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto )
	virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-xpmdir.patch
	epatch ${FILESDIR}/${PN}-ComplexProgramTargetNoMan.patch
	epatch ${FILESDIR}/${PN}-c++.patch
}

src_compile()
{
	PATH=${PATH}:/usr/X11R6/bin
	xmkmf || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install()
{
	einstall DESTDIR="${D}" BINDIR="/usr/bin" || die "Installation failed"

	insinto /usr/share/WMcdplay
	doins XPM/*.art

	dodoc ARTWORK README

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
