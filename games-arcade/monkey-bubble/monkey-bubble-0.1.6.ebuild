# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.1.6.ebuild,v 1.3 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="A Puzzle Bobble clone"
HOMEPAGE="http://monkey-bubble.tuxfamily.org"
SRC_URI="http://monkey-bubble.tuxfamily.org/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0

	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/librsvg-2.0
	>=gnome-base/gconf-2.0
	>=media-libs/gstreamer-0.6*"

filter-flags "-fomit-frame-pointer"

src_install() {

	egamesinstall || die
	dodoc AUTHORS ChangeLog || die "Failed to copy documentation"
	prepgamesdirs

}
