# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkatlantic/gtkatlantic-0.3.3.ebuild,v 1.1 2005/04/10 04:56:53 mr_bones_ Exp $

inherit eutils games

DESCRIPTION="Monopoly-like game that works with the monopd server"
HOMEPAGE="http://gtkatlantic.gradator.net/"
SRC_URI="http://gtkatlantic.gradator.net/downloads/v0.3/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/libxml2-2.4.0
	>=media-libs/libpng-1.0.12"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp src/icon.xpm gtkatlantic.xpm || die "cp failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS ChangeLog NEWS
	doicon gtkatlantic.xpm
	make_desktop_entry gtkatlantic "GTK Atlantic" gtkatlantic.xpm
	prepgamesdirs
}
