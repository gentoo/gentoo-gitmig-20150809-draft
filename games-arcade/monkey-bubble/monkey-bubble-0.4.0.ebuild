# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.4.0.ebuild,v 1.4 2007/06/01 00:35:59 mr_bones_ Exp $

inherit autotools eutils gnome2

DESCRIPTION="A Puzzle Bobble clone"
HOMEPAGE="http://home.gna.org/monkeybubble/"
SRC_URI="http://home.gna.org/monkeybubble/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2.12
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/librsvg-2.0
	>=gnome-base/gconf-2.0
	=media-libs/gstreamer-0.10*
	>=dev-libs/libxml2-2.6.7
	app-text/scrollkeeper"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-gnome-doc.patch
	eautoreconf
}
