# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-0.22_alpha18947.ebuild,v 1.2 2008/12/15 20:01:35 angelos Exp $

EAPI=1
inherit qt4 mythtv

DESCRIPTION="A collection of themes for the MythTV project."
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-4.3:4
	=media-tv/mythtv-${MY_PV}*"

src_compile() {
	./configure --prefix=/usr || die "configure died"

	eqmake4 myththemes.pro -o "Makefile" || die "qmake failed"
}

src_install() {
	einstall INSTALL_ROOT="${D}" || die "install failed"
}
