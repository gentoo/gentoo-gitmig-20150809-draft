# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mindless/mindless-1.4.ebuild,v 1.1 2004/02/28 21:42:52 vapier Exp $

inherit games

DESCRIPTION="play collectable/trading card games (Magic: the Gathering and possibly others) against other people"
HOMEPAGE="http://mindless.sourceforge.net/"
SRC_URI="mirror://sourceforge/mindless/${P}.tar.gz
	http://www.e-league.com/files/approracle.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="media-libs/gdk-pixbuf"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	newgamesbin mindless mindless-bin
	dogamesbin ${FILESDIR}/mindless
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/mindless
	insinto ${GAMES_DATADIR}/${PN}
	doins ${WORKDIR}/*.dat ${WORKDIR}/sets/*.dat
	dodoc CHANGES README TODO
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "mindless is now a wrapper that searches"
	einfo "for cardinfo files and then runs mindless-bin."
	einfo "If you wish to run mindless yourself, please"
	einfo "use mindless-bin."
}
