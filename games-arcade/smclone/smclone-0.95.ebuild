# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-0.95.ebuild,v 1.3 2005/04/05 06:18:13 mr_bones_ Exp $

inherit games eutils

DESCRIPTION="clone of Super Mario World"
HOMEPAGE="http://smclone.arturh.com/"
SRC_URI="mirror://sourceforge/smclone/SMC_${PV}.zip
	mirror://sourceforge/smclone/music_2.0_RC_1.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-gfx"
DEPEND="${RDEPEND}
	app-arch/unzip
	>=sys-apps/portage-2.0.51"

S="${WORKDIR}/SMC 0.95 Preview 1"

src_unpack() {
	unpack SMC_${PV}.zip
	cd "${S}"
	unpack music_2.0_RC_1.zip

	find . '(' -name '*.dll' -o -name '*.exe' ')' -exec rm {} \;
	cd src/unix
	chmod go+rw *
	edos2unix Makefile.am autogen.sh configure.ac ../savegame.cpp
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:g" \
		configure.ac
	chmod a+x autogen.sh
	./autogen.sh || die "autogen failed"
	cd ..
	epatch "${FILESDIR}"/${P}-use-HOME.patch
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
