# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mindless/mindless-1.3.ebuild,v 1.2 2004/02/20 06:53:36 mr_bones_ Exp $

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
	dogamesbin mindless ${FILESDIR}/playmindless
	insinto ${GAMES_DATADIR}/${PN}
	doins ${WORKDIR}{/,/sets/}*.dat
	dodoc CHANGES README TODO
	prepgamesdirs
}

pkg_postinst() {
	einfo "A wrapper script has been installed."
	einfo "To play, just run 'playmindless'."

	games_pkg_postinst
}
