# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.3.2.ebuild,v 1.8 2004/11/21 01:44:37 mr_bones_ Exp $

inherit gnome2 eutils

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
	>=media-libs/gstreamer-0.8
	>=dev-libs/libxml2-2.6.7
	app-text/scrollkeeper
	media-libs/gst-plugins"

src_compile() {
	epatch "${FILESDIR}/${P}.amd64.patch"
	gnome2_src_compile
}
