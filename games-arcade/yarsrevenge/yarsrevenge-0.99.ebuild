# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/yarsrevenge/yarsrevenge-0.99.ebuild,v 1.4 2004/06/19 17:22:18 jhuebel Exp $

inherit eutils games

DESCRIPTION="remake of the Atari 2600 classic Yar's Revenge"
HOMEPAGE="http://freshmeat.net/projects/yarsrevenge/"
SRC_URI="http://www.autismuk.freeserve.co.uk/yar-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~amd64"
IUSE=""

DEPEND="media-libs/libsdl"

S="${WORKDIR}/yar-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-math.patch
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
