# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/basqet/basqet-0.1.0.ebuild,v 1.1 2009/11/04 19:28:20 yngwin Exp $

EAPI="2"
inherit eutils qt4

DESCRIPTION="Keep your notes, pictures, ideas, and information in Baskets"
HOMEPAGE="http://code.google.com/p/basqet/"
SRC_URI="http://basqet.googlecode.com/files/${P}-src.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4 Basqet.pro
}

src_install() {
	newbin Basqet ${PN}
	newicon resources/picking_basket_32x32_transp.png ${PN}.png
	make_desktop_entry ${PN} Basqet ${PN}.png "Qt;Utility"
}
