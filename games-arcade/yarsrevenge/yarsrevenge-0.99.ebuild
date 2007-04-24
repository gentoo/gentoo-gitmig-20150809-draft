# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/yarsrevenge/yarsrevenge-0.99.ebuild,v 1.7 2007/04/24 15:29:04 drizzt Exp $

inherit eutils games

DESCRIPTION="remake of the Atari 2600 classic Yar's Revenge"
HOMEPAGE="http://freshmeat.net/projects/yarsrevenge/"
SRC_URI="http://www.autismuk.freeserve.co.uk/yar-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/libsdl"

S=${WORKDIR}/yar-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-math.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	prepgamesdirs
}
