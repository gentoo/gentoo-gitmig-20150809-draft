# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.1.30-r1.ebuild,v 1.1 2004/08/23 21:49:38 rizzo Exp $

inherit eutils gnome2

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

RDEPEND=">=gnome-base/libgnomeui-2.2*
	=dev-libs/glib-1.2*
	>=app-text/scrollkeeper-0.3*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gnocatan-reject_trade_2x.patch
}
src_compile() {
	export G2CONF="${G2CONF} `use_enable nls`"
	gnome2_src_compile
}

src_install() {
	DOCS="AUTHORS ChangeLog README"
	gnome2_src_install
}
