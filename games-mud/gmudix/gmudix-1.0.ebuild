# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gmudix/gmudix-1.0.ebuild,v 1.6 2005/06/15 18:54:16 wolf31o2 Exp $

inherit games

DESCRIPTION="An improved version of MUDix, a MUD client for the Linux console.  It is designed to run as an X application, and was developed with GTK+ 2.0.  gMUDix has all the features of MUDix and more, including ANSI color mapping, aliasing, macros, paths, tab completions, timers, triggers, variables, and an easy-to-use script language."
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/gmudix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib
	>=dev-libs/atk-1.0
	>=dev-libs/glib-2.0
	>=x11-libs/pango-1.0
	>=x11-libs/gtk+-2.0"

src_install() {
	dogamesbin src/gmudix
	dodoc AUTHORS ChangeLog README TODO doc/*txt
	prepgamesdirs
}
