# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gtkatlantic/gtkatlantic-0.3.2.ebuild,v 1.2 2005/02/21 00:46:55 kugelfang Exp $

inherit games

DESCRIPTION="Monopoly-like game that works with the monopd server"
HOMEPAGE="http://gtkatlantic.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtkatlantic/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/libxml2-2.4.0
	>=media-libs/libpng-1.0.12"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS ChangeLog NEWS
	prepgamesdirs
}
