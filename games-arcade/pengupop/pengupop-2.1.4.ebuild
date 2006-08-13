# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/pengupop/pengupop-2.1.4.ebuild,v 1.1 2006/08/13 22:49:39 mr_bones_ Exp $

inherit games

DESCRIPTION="Networked multiplayer-only Puzzle Bubble clone"
HOMEPAGE="http://www.junoplay.com/pengupop"
SRC_URI="http://www.junoplay.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
	prepgamesdirs
}
