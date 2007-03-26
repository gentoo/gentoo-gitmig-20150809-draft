# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-0.97.ebuild,v 1.4 2007/03/26 14:58:16 wolf31o2 Exp $

inherit eutils games

MUSIC_V=2.0_RC_1
DESCRIPTION="clone of Super Mario World"
HOMEPAGE="http://smclone.sourceforge.net/"
SRC_URI="mirror://sourceforge/smclone/SMC_${PV}_source.zip
	mirror://sourceforge/smclone/SMC_${PV}_game.zip
	mirror://sourceforge/smclone/music_${MUSIC_V}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-gfx"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PVR}"

src_unpack() {
	unpack SMC_${PV}_source.zip SMC_${PV}_game.zip
	cd "${S}"
	unpack music_${MUSIC_V}.zip

	find . '(' -name '*.dll' -o -name '*.exe' ')' -exec rm {} \;
	edos2unix Makefile.am autogen.sh configure.ac src/preferences.cpp src/savegame.cpp
	chmod a+x autogen.sh
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:g" \
		configure.ac src/preferences.cpp

	#Bump VERSION to the correct one for this release
	sed -i \
		-e "s/VERSION=0.96/VERSION=0.97/" \
		configure.ac \
		|| die "sed failed"
	./autogen.sh || die "autogen failed"
	chmod a+x configure
	cd src
	epatch "${FILESDIR}"/${P}-use-HOME.patch
}

src_install() {
	dogamesbin src/smc || die "dogamesbin failed"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* || die "doins"
	# Clean up data directory
	rm -f "${D}${GAMES_DATADIR}"/${PN}/{data/,}Makefile*
	dodoc *.txt ../readme-linux.txt
	cd ..
	dohtml *.html *.css
	prepgamesdirs
}
