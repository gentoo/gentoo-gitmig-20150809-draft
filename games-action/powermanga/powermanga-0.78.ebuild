# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/powermanga/powermanga-0.78.ebuild,v 1.2 2004/02/10 06:14:15 mr_bones_ Exp $

inherit games

DESCRIPTION="An arcade 2D shoot-em-up game"
HOMEPAGE="http://linux.tlk.fr/"
SRC_URI="http://www.tlk.fr/lesjeux/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT=0
IUSE=""

DEPEND="virtual/glibc
	>=media-libs/libsdl-0.11.0
	media-libs/sdl-mixer"

src_compile() {
	egamesconf --prefix=/usr || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	local f

	dogamesbin powermanga        || die "dogamesbin failed"
	doman powermanga.6           || die "doman failed"
	dodoc AUTHORS CHANGES README || die "dodoc failed"

	insinto ${GAMES_DATADIR}/powermanga/sounds
	doins sounds/*

	insinto ${GAMES_DATADIR}/powermanga/graphics
	doins graphics/*

	insinto /var/games
	for f in powermanga.hi-easy powermanga.hi powermanga.hi-hard
	do
		touch ${D}/var/games/${f} || \
			die "touch ${f} failed"
		fperms 664 /var/games/${f} || \
			die "fperms ${f} failed"
	done

	prepgamesdirs
}
