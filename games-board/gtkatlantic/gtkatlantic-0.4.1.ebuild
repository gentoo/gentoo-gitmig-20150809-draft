# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkatlantic/gtkatlantic-0.4.1.ebuild,v 1.1 2004/07/21 09:01:58 mr_bones_ Exp $

inherit games

DESCRIPTION="Monopoly-like game that works with the monopd server"
HOMEPAGE="http://gtkatlantic.gradator.net/"
SRC_URI="http://gtkatlantic.gradator.net/downloads/v0.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*
	>=dev-libs/libxml2-2.4.0
	>=media-libs/libpng-1.0.12"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
