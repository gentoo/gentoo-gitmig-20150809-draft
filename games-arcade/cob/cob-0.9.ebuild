# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.5 2004/06/18 19:05:59 jhuebel Exp $

inherit games

DESCRIPTION="Cruising on Broadway: a painting-type game"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha ~amd64"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	egamesinstall || die "egamesinstall failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
