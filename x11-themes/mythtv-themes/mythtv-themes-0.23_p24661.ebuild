# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.23_p24661.ebuild,v 1.2 2011/07/28 20:59:44 cardoe Exp $

EAPI=2
inherit qt4 mythtv

DESCRIPTION="A collection of themes for the MythTV project."
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	=media-tv/mythtv-${MY_PV}*"

src_configure() {
	sh ./configure --prefix=/usr || die "configure died"
}

src_compile() {
	eqmake4 myththemes.pro || die "qmake failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}
