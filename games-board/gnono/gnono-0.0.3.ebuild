# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnono/gnono-0.0.3.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

inherit games

DESCRIPTION="rewrite of Windows card game WUNO"
SRC_URI="ftp://ftp.paw.co.za/pub/PAW/sources/${P}.tar.gz"
HOMEPAGE="http://www.paw.co.za/projects/gnono/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="gnome-base/gnome-libs
	=dev-libs/glib-1.2*
	virtual/x11
	media-libs/gdk-pixbuf
	=x11-libs/gtk+-1.2*"

src_compile() {
	egamesconf `use_enable nls`
	emake || die
}

src_install() {
	einstall
	prepgamesdirs
}
