# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/4stattack/4stattack-2.1.4.ebuild,v 1.2 2004/01/29 08:55:46 vapier Exp $

inherit games eutils

DESCRIPTION="Connect-4 game, single or network multiplayer"
HOMEPAGE="http://forcedattack.sourceforge.net/"
SRC_URI="mirror://sourceforge/forcedattack/4stAttack-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 hppa"

DEPEND=">=dev-python/pygame-1.5"

S=${WORKDIR}/4stAttack-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	# move the doc files aside so it's easier to install the game files
	mv README.txt credits.txt changelog.txt ..
	rm GPL version~

	#This patch makes the game save settings in $HOME instead
	# of in /usr/share/games
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	dogamesbin ${FILESDIR}/4stattack
	dosed "s:GENTOO_DIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/4stattack
	dodoc ../README.txt ../credits.txt ../changelog.txt

	dodir ${GAMES_DATADIR}/4stattack
	cp -R * ${D}/${GAMES_DATADIR}/4stattack/

	prepgamesdirs
}
