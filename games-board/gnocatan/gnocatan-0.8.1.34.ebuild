# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.1.34.ebuild,v 1.2 2004/09/10 19:13:47 rizzo Exp $

inherit eutils gnome2

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
#SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"
SRC_URI="http://gnocatan.sourceforge.net/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="nls"

RDEPEND=">=gnome-base/libgnomeui-2.2*
	=dev-libs/glib-1.2*
	>=app-text/scrollkeeper-0.3*"

src_compile() {
	export G2CONF="${G2CONF} `use_enable nls`"
	gnome2_src_compile
}

src_install() {
	DOCS="ABOUT-NLS AUTHORS ChangeLog README COPYING INSTALL TODO NEWS"
	gnome2_src_install
}
