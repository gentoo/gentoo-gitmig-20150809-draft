# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/rockdodger/rockdodger-0.6.0a-r1.ebuild,v 1.3 2006/04/24 14:25:55 tupone Exp $

inherit eutils games

DESCRIPTION="Dodge the rocks for as long as possible until you die. Kill greeblies to make the universe safe for non-greeblie life once again."
HOMEPAGE="http://spacerocks.sourceforge.net/"
SRC_URI="mirror://sourceforge/spacerocks/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

RDEPEND=">=media-libs/libsdl-1.2.2
	>=media-libs/sdl-image-1.2
	>=media-libs/sdl-mixer-1.2"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	GAME_DEST_DIR="${GAMES_DATADIR}/${PN}"
	unpack ${A}
	cd "${S}"

	# Modify highscores & data directory and add our CFLAGS to the Makefile
	sed -i \
		-e "s:\./data:${GAME_DEST_DIR}:" \
		-e "s:/usr/share/rockdodger/\.highscore:${GAMES_STATEDIR}/rockdodger.scores:" \
		-e 's:umask(0111):umask(0117):' main.c \
			|| die " sed main.c failed"
	sed -i \
		-e "s:-g:${CFLAGS}:" Makefile \
			|| die "sed Makefile failed"

	# The 512 chunksize makes the music skip
	sed -i \
		-e "s:512:1024:" sound.c \
			|| die "sed sound.c failed"
	epatch "${FILESDIR}/${PV}-sec.patch" \
		"${FILESDIR}/${P}"-gcc41.patch
}

src_install() {
	dogamesbin rockdodger || die "dogamesbin failed"
	insinto "${GAME_DEST_DIR}"
	doins data/* || die "doins failed"

	dodir "${GAMES_STATEDIR}"
	touch "${D}/${GAMES_STATEDIR}/rockdodger.scores"
	fperms 660 "${GAMES_STATEDIR}/rockdodger.scores"

	prepgamesdirs
}
