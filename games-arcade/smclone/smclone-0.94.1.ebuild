# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/smclone/smclone-0.94.1.ebuild,v 1.3 2005/02/08 23:18:08 wolf31o2 Exp $

inherit games eutils

DESCRIPTION="clone of Super Mario World"
HOMEPAGE="http://smclone.arturh.com/"
SRC_URI="mirror://sourceforge/smclone/SMC_${PV}_source.zip
	mirror://sourceforge/smclone/smc_${PV}_linux_x86.tar.gz
	mirror://sourceforge/smclone/SMC_93_music.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-mixer
	media-libs/sdl-ttf
	media-libs/sdl-gfx"
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

S=${WORKDIR}/${PV}/src/unix

src_unpack() {
	unpack ${A}
	cd ${S}
	chmod go+rw *
	epatch ${FILESDIR}/${PV}-gentoo-paths.patch
	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:g" \
		-e "s:0\.93:${PV}:" \
		configure.ac
	sed -i 's:-Wmissing-prototypes:-Wno-deprecated:' Makefile.am
	chmod a+x autogen.sh
	env WANT_AUTOMAKE=1.8 ./autogen.sh || die "autogen failed"
	cd ..
	sed -i '/define LEVEL_DIR/d' include/savegame.h
	sed -i '/define VERSION/d' include/globals.h
	epatch ${FILESDIR}/${PV}-use-HOME.patch
}

src_install() {
	dogamesbin smclone || die "smclone"
	cd ${WORKDIR}/smc-${PV}
	dodoc *.rtf
	cd ${PV}
	insinto ${GAMES_DATADIR}/${PN}
	doins -r Preferences.ini World levels data/* || die "doins"
	doins -r ${WORKDIR}/0.93.1/data/music || die "music"
	prepgamesdirs
}
