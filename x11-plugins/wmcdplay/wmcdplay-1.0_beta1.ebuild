# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcdplay/wmcdplay-1.0_beta1.ebuild,v 1.1 2004/07/17 22:07:32 s4t4n Exp $

inherit eutils

IUSE=""

MY_P=${P/_beta/-beta}
S=${WORKDIR}/${PN}

DESCRIPTION="CD player applet for WindowMaker"
SRC_URI="http://www.geocities.com/SiliconValley/Vista/2471/files/${MY_P}.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/Vista/2471/"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

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
