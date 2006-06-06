# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gmudix/gmudix-1.0.ebuild,v 1.8 2006/06/06 06:08:26 mr_bones_ Exp $

inherit games

DESCRIPTION="A GTK+ 2.0 MUD client with ANSI color mapping, aliasing, macros, paths, tab completions, timers, triggers, variables, and an easy-to-use script language and more"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/gmudix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
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
