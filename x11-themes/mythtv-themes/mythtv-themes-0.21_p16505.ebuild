# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.21_p16505.ebuild,v 1.8 2009/07/19 15:37:52 cardoe Exp $

EAPI=2
inherit qt3 mythtv

DESCRIPTION="A collection of themes for the MythTV project."
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=x11-libs/qt-3.3:3
	=media-tv/mythtv-${MY_PV}*"

src_configure() {
	sh ./configure --prefix=/usr || die "configure died"
}

src_compile() {
	eqmake3 myththemes.pro || die "eqmake3 failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}
