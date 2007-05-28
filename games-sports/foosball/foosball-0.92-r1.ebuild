# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/foosball/foosball-0.92-r1.ebuild,v 1.1 2007/05/28 22:39:06 tupone Exp $

inherit eutils games

DESCRIPTION="foosball game that uses SDL"
HOMEPAGE="http://freshmeat.net/projects/foosball/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	make_desktop_entry ${PN} Foosball
	prepgamesdirs
}
