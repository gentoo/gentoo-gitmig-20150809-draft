# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/maelstrom/maelstrom-3.0.6-r1.ebuild,v 1.3 2004/02/20 06:13:56 mr_bones_ Exp $

inherit eutils games

MY_P=Maelstrom-${PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="An asteroids battle game"
SRC_URI="http://www.devolution.com/~slouken/Maelstrom/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.devolution.com/~slouken/Maelstrom/"

KEYWORDS="x86 ppc alpha amd64"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=media-libs/libsdl-1.1.5
	>=media-libs/sdl-net-1.2.2"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-security.patch

	# Install the data into $(datadir)/..., not $(prefix)/games/...
	sed -i \
		-e "s:(prefix)/games/:(datadir)/:" configure || \
			die "sed configure failed"
	# Install the high scores file in ${GAMES_STATEDIR}
	sed -i \
		-e "s:path.Path(MAELSTROM_SCORES):\"${GAMES_STATEDIR}/\"MAELSTROM_SCORES:" scores.cpp || \
			die "sed scores.cpp failed"
}

src_install() {
	egamesinstall || die
	dodoc Changelog README* Docs/{Maelstrom-Announce,*FAQ,MaelstromGPL_press_release,*.Paper,Technical_Notes*} || \
		die "dodoc failed"
	insinto /usr/share/pixmaps
	newins ${D}${GAMES_DATADIR}/Maelstrom/icon.xpm maelstrom.xpm || \
		die "newins failed"
	make_desktop_entry Maelstrom "Maelstrom" maelstrom.xpm

	# Put the high scores file in the right place
	insinto ${GAMES_STATEDIR}
	doins ${D}${GAMES_DATADIR}/Maelstrom/Maelstrom-Scores || die "doins failed"
	rm -f ${D}${GAMES_DATADIR}/Maelstrom/Maelstrom-Scores

	# clean up some cruft
	rm -f ${D}${GAMES_DATADIR}/Maelstrom/Images/Makefile*
	prepgamesdirs

	# make sure we can update the high scores
	fperms 664 ${GAMES_STATEDIR}/Maelstrom-Scores         || die "fperms failed"
}
