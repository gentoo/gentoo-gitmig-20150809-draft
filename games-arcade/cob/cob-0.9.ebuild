# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.7 2005/10/30 03:33:36 weeve Exp $

inherit games

DESCRIPTION="Cruising on Broadway: a painting-type game"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	egamesinstall || die "egamesinstall failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
