# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/gmudix/gmudix-0.10.ebuild,v 1.2 2004/02/03 00:05:09 mr_bones_ Exp $

inherit games

DESCRIPTION="An improved version of MUDix, a MUD client for the Linux console.  It is designed to run as an X application, and was developed with GTK+ 2.0.  gMUDix has all the features of MUDix and more, including ANSI color mapping, aliasing, macros, paths, tab completions, timers, triggers, variables, and an easy-to-use script language."
SRC_URI="http://dw.nl.eu.org/gmudix/${P}.tar.gz"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	>=dev-libs/atk-1.0
	>=dev-libs/glib-2.0
	>=media-libs/freetype-2.1.4
	>=sys-libs/ncurses-5.2
	>=x11-libs/pango-1.0
	>=x11-libs/gtk+-2.0"

src_install() {
	dobin src/gmudix
	dodoc AUTHORS ChangeLog INSTALL README TODO doc/*
	prepgamesdirs
}
