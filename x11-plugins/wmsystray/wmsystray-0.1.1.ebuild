# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmsystray/wmsystray-0.1.1.ebuild,v 1.1 2004/07/17 11:25:37 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="Window Maker dock app that provides a system tray for GNOME/KDE applications"
SRC_URI="http://kai.vm.bytemark.co.uk/~arashi/wmsystray/release/${P}.tar.bz2"
HOMEPAGE="http://kai.vm.bytemark.co.uk/~arashi/wmsystray/"

DEPEND="virtual/x11"
RDEPEND=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-cflags.patch

}

src_compile() {

	emake EXTRACFLAGS="${CFLAGS}" || die "Compilation failed"

}

src_install() {

	einstall || die "Installation failed"
	dodoc AUTHORS HACKING README
	prepallman

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop

}
