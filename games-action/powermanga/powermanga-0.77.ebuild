# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/powermanga/powermanga-0.77.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

DESCRIPTION="An arcade 2D shoot-em-up game"
HOMEPAGE="http://linux.tlk.fr/"
# TLK seems to always use the same name for releases.  That's bad.
#SRC_URI="http://www.tlk.fr/lesjeux/${PN}.tar.gz"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT=0

DEPEND="virtual/glibc
	media-libs/libsdl
	media-libs/sdl-mixer"

src_compile() {
	emake CXXFLAGS="${CXXFLAGS}" PREFIX=/usr || die
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
