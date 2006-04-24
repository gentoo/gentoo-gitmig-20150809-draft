# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.3.2.ebuild,v 1.11 2006/04/24 12:33:10 tupone Exp $

inherit eutils gnome2

DESCRIPTION="A Puzzle Bobble clone"
HOMEPAGE="http://home.gna.org/monkeybubble/"
SRC_URI="http://home.gna.org/monkeybubble/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/librsvg-2.0
	>=gnome-base/gconf-2.0
	=media-libs/gstreamer-0.8*
	>=dev-libs/libxml2-2.6.7
	app-text/scrollkeeper
	=media-libs/gst-plugins-0.8*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}.amd64.patch"
	sed -i \
		-e "s:-Werror::" \
		src/util/Makefile.in \
		src/input/Makefile.in \
		src/monkey/Makefile.in \
		src/view/Makefile.in \
		src/audio/Makefile.in \
		src/net/Makefile.in \
		src/net/Makefile.in \
		src/ui/Makefile.in
}
