# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.1.9.ebuild,v 1.1 2004/04/07 03:45:10 mr_bones_ Exp $

inherit gnome2

DESCRIPTION="A Puzzle Bobble clone"
HOMEPAGE="http://home.gna.org/monkeybubble/"
SRC_URI="http://home.gna.org/monkeybubble/downloads/${P}.tar.gz"

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
