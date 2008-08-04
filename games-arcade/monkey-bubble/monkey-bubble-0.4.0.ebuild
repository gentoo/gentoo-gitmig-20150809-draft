# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/monkey-bubble/monkey-bubble-0.4.0.ebuild,v 1.7 2008/08/04 19:20:37 mr_bones_ Exp $

EAPI=1
inherit autotools eutils gnome2

DESCRIPTION="A Puzzle Bobble clone"
HOMEPAGE="http://www.monkey-bubble.org/"
SRC_URI="http://home.gna.org/monkeybubble/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	>=dev-libs/glib-2.12
	>=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/librsvg-2.0
	>=gnome-base/gconf-2.0
	media-libs/gstreamer:0.10
	>=dev-libs/libxml2-2.6.7
	media-sound/esound"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/intltool"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch \
		"${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-gnome-doc.patch
	eautoreconf
}
