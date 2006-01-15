# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.8 2006/01/15 14:30:05 mr_bones_ Exp $

inherit games

DESCRIPTION="Cruising on Broadway: a painting-type game"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# gcc34 compile fix (bug #119061)
	sed -i \
		-e '195 s/;//' \
		cob/sdw.hxx \
		|| die "sed failed"
}

src_install() {
	egamesinstall || die "egamesinstall failed"
	dodoc AUTHORS ChangeLog README
	prepgamesdirs
}
