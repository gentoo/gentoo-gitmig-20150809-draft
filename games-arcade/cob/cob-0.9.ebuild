# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.2 2004/02/20 06:20:00 mr_bones_ Exp $

inherit games

DESCRIPTION="Cruising on Broadway: a painting-type game where you have to roam
the grid avoiding the 'chasers'"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	egamesinstall                  || die "egamesinstall failed"
	dodoc AUTHORS ChangeLog README || die "dodoc failed"
	prepgamesdirs
}
