# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/pathological/pathological-1.1.3.ebuild,v 1.6 2004/11/05 05:10:06 josejx Exp $

inherit games

DESCRIPTION="An enriched clone of the game 'Logical' by Rainbow Arts"
HOMEPAGE="http://pathological.sourceforge.net/"
SRC_URI="mirror://sourceforge/pathological/${P}.tar.gz"
KEYWORDS="x86 ~amd64 ~ppc"
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
			-e '5,$ s/=/ /g' makehtml \
			|| die "sed makehtml failed"
	} || {
		echo "#!/bin/sh" > makehtml \
		|| die "clearing makehtml failed"
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
	dogamesbin pathological || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	insopts -m0750
	doins pathological.py || die "doins failed"
	exeinto "${GAMES_LIBDIR}/${PN}"
	doexe write-highscores || die "doexe failed"

	# removed some unneeded resource files
	rm -f graphics/*.xcf
	rm -f sounds/*.orig
	# "install" resource files
	# Use cp, not mv so install can be done multiple times (for ebuild devel).
	cp -R circuits graphics music sounds "${D}/${GAMES_DATADIR}/${PN}" \
		|| die "cp failed"

	# setup high score file
	insinto "${GAMES_STATEDIR}"
	insopts -m0664
	doins pathological_scores || die "doins failed (pathological_scores)"

	# documentation
	dodoc README TODO
	doman pathological.6.gz
	use doc && dohtml -r html/

	prepgamesdirs
}
