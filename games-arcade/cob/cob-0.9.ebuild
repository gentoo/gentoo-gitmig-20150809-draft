# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/cob/cob-0.9.ebuild,v 1.12 2008/04/30 21:48:15 nyhm Exp $

inherit eutils games

DESCRIPTION="Cruising on Broadway: a painting-type game"
HOMEPAGE="http://www.autismuk.freeserve.co.uk/"
SRC_URI="http://www.autismuk.freeserve.co.uk/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
	# gcc34 compile fix (bug #119061)
	sed -i \
		-e '195 s/;//' \
		cob/sdw.hxx \
		|| die "sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS README
	prepgamesdirs
}
