# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pathological/pathological-1.1.2.ebuild,v 1.2 2004/02/20 06:53:36 mr_bones_ Exp $

inherit games

MY_P="${P/-/_}"
DESCRIPTION="An enriched clone of the game 'Logical' by Rainbow Arts"
HOMEPAGE="http://pathological.sourceforge.net/"
SRC_URI="mirror://sourceforge/pathological/${MY_P}.tar.gz"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

DEPEND="doc? ( media-libs/netpbm )
	>=sys-apps/sed-4"
RDEPEND=">=dev-python/pygame-1.5.5
	dev-lang/python"

src_unpack() {
	unpack ${A}
	cd ${S}

	use doc && {
		sed -i \
			-e '5,$ s/=/ /g' makehtml || \
				die "sed makehtml failed"
	} || {
		echo "#!/bin/sh" > makehtml || \
			die "clearing makehtml failed"
	}

	sed -i \
		-e "/^cd / s/usr/share/pathological${GAMES_DATADIR}/${PN}" \
		pathological || die "sed pathological failed"

	sed -i \
		-e "/^write_highscores / s/usr/lib/pathological/bin${GAMES_LIBDIR}/${PN}" \
		pathological.py || die "sed pathological.py failed"
}

src_install() {
	# executables
	dogamesbin pathological
	insinto ${GAMES_DATADIR}/${PN}
	insopts -m0750
	doins pathological.py
	exeinto ${GAMES_LIBDIR}/${PN}
	doexe write-highscores

	# removed some unneeded resource files
	rm -f graphics/*.xcf
	rm -f sounds/*.orig
	# "install" resource files
	mv circuits graphics music sounds ${D}/${GAMES_DATADIR}/${PN}

	# setup high score file
	insinto ${GAMES_STATEDIR}
	insopts -m0664
	doins pathological_scores

	# documentation
	dodoc README TODO
	doman pathological.6.gz
	use doc && dohtml -r html/

	prepgamesdirs
}
