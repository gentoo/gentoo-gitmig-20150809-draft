# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.1.6.ebuild,v 1.5 2004/04/06 03:03:52 vapier Exp $

inherit games flag-o-matic

DESCRIPTION="A Puzzle Bobble clone"
HOMEPAGE="http://monkey-bubble.tuxfamily.org"
SRC_URI="http://monkey-bubble.tuxfamily.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/librsvg-2.0
	>=gnome-base/gconf-2.0
	>=media-libs/gstreamer-0.6*"

src_unpack() {
	filter-flags -fomit-frame-pointer
	unpack ${A}
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog
	prepgamesdirs
}
