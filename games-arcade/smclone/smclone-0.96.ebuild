# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-0.96.ebuild,v 1.1 2005/06/08 01:46:12 mr_bones_ Exp $

inherit games eutils

MUSIC_V=2.0_RC_1
DESCRIPTION="clone of Super Mario World"
HOMEPAGE="http://smclone.arturh.com/"
SRC_URI="mirror://sourceforge/smclone/SMC_${PV}_source.zip
	mirror://sourceforge/smclone/SMC_${PV}_game.zip
	mirror://sourceforge/smclone/music_${MUSIC_V}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-gfx"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-apps/portage-2.0.51"

S="${WORKDIR}/${PVR}"

src_unpack() {
	unpack SMC_${PV}_source.zip
	unpack SMC_${PV}_game.zip
	cd "${S}"
	unpack music_${MUSIC_V}.zip

	find . '(' -name '*.dll' -o -name '*.exe' ')' -exec rm {} \;
	cd src/unix
	chmod go+rw *
	edos2unix Makefile.am autogen.sh configure.ac ../savegame.cpp
	epatch "${FILESDIR}"/${PN}-0.95-gentoo-paths.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:g" \
		configure.ac
	chmod a+x autogen.sh
	./autogen.sh || die "autogen failed"
	cd ..
	epatch "${FILESDIR}"/${PN}-0.95-use-HOME.patch
}

src_compile() {
	cd src/unix
	egamesconf || die
	emake || die
}

src_install() {
	dogamesbin src/unix/smc || die "smc"
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r data/* levels world || die "doins"
	dodoc *.txt ../readme-linux.txt
	cd ..
	dohtml *.html *.css
	prepgamesdirs
}
