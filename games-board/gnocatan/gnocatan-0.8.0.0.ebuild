# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.0.0.ebuild,v 1.3 2003/10/18 07:36:04 mr_bones_ Exp $

inherit games gnome2

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND=">=gnome-base/libgnomeui-2.2*
	=dev-libs/glib-1.2*
	>=app-text/scrollkeeper-0.3*"

G2CONF="${G2CONF} `use_enable nls`"
DOCS="AUTHORS ChangeLog README"

src_install() {
	gnome2_src_install
	dogamesbin ${D}/usr/bin/* || die "dogamesbin failed"
	rm -rf ${D}/usr/bin/
	prepgamesdirs
}
