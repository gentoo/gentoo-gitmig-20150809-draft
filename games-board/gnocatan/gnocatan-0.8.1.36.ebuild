# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.1.36.ebuild,v 1.1 2004/09/27 01:10:07 rizzo Exp $

inherit eutils gnome2 debug

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls debug"

RDEPEND=">=gnome-base/libgnomeui-2.2*
	=dev-libs/glib-1.2*
	>=app-text/scrollkeeper-0.3*"

src_compile() {
	export G2CONF="${G2CONF} `use_enable nls`"
	export G2CONF="${G2CONF} `use_enable debug`"
	gnome2_src_compile
}

src_install() {
	DOCS="ABOUT-NLS AUTHORS ChangeLog README COPYING INSTALL TODO NEWS"
	gnome2_src_install
}
