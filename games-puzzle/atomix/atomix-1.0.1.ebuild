# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/atomix/atomix-1.0.1.ebuild,v 1.8 2004/10/23 14:00:16 liquidx Exp $

inherit gnome2

DESCRIPTION="a little mind game for GNOME2"
HOMEPAGE="http://triq.net/~pearl/atomix.php"
SRC_URI="http://triq.net/~pearl/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND=">=x11-libs/pango-1.0.3
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/glib-2.0.4
	>=gnome-base/gconf-1.1.11
	>=gnome-base/libglade-2.0.0
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libbonoboui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.0
	>=dev-libs/libxml2-2.4.23
	dev-perl/XML-Parser"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

DOCS="AUTHORS ChangeLog NEWS README* TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# bug #66142
	sed -i \
		-e 's/default:/default:;/' src/goal-view.c \
		|| die "sed failed"
	sed -i \
		-e '581 s/default:/default:;/' src/level-convert.c \
		|| die "sed failed"

	sed -i \
		-e 's/games.games/games:games/' Makefile.in \
		|| die "sed failed"

	# Seems to fix the infamous "OrigTree module" bug
	cd ${S}; intltoolize -c -f || die
	sed -i -e 's/@INTLTOOL_ICONV@/iconv/' intltool-merge.in
}

