# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/aklabeth/aklabeth-1.0.ebuild,v 1.4 2004/12/16 15:35:32 josejx Exp $

inherit games

DESCRIPTION="A remake of Richard C. Garriott's Ultima prequel"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="media-libs/libsdl"

src_install() {
	dogamesbin src/aklabeth || die "dogamesbin failed"
	dodoc AUTHORS README NEWS
	prepgamesdirs
}
