# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands/eternal-lands-1.0.0.ebuild,v 1.4 2004/11/30 03:51:31 kingtaco Exp $

inherit games

DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
TMP_PV=${PV%_p*}
SRC_URI="http://el.tfm.ro/el_${TMP_PV//.}.zip
	ftp://ftp.berlios.de/pub/elc/elc_${PV//.}.tgz"

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.5
	>media-libs/openal-20020127
	media-libs/libvorbis
	>=dev-libs/libxml2-2.6.7"
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/elc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed \
		-e "s@CFLAGS=\$(PLATFORM) -Wall -ggdb -pipe@CFLAGS=${CFLAGS}@g" \
		-e 's@OPTIONS=@OPTIONS=-DDATA_DIR="\\"${GAMES_DATADIR}/${PN}/\\"" @g' \
		Makefile.linux > Makefile \
		|| die "sed failed"
	sed \
		-e 's/#browser/browser/g' \
		-e 's/browser = mozilla/#browser = mozilla/g' \
		-e "s@data_dir = /usr/local/games/el/@#data_dir = ${GAMES_DATADIR}/${PN}/@g" \
		el.ini > ../el.ini \
		|| die "sed failed"
	cd ..
	cp license.txt EULA || die "cp failed"
	rm -fr Encyclopedia/images/.xvpics
}

src_compile() {
	emake || die "emake failed"
	cp el.x86.linux.bin ../el.x86.linux.bin || die "cp failed"
}

src_install () {
	cd "${WORKDIR}"
	insinto "${GAMES_DATADIR}/${PN}"
	newgamesbin el.x86.linux.bin el
	dodoc changes.txt faq.txt readme.txt EULA
	doins el.ini *.lst el_icon.png icon.bmp global_filters.txt global_ignores.txt \
		|| die "Files failed to be installed"
	cp -R 2dobjects 3dobjects Encyclopedia maps md2 sound textures tiles \
		"${D}/${GAMES_DATADIR}/${PN}" \
		|| die "copy failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To run the game: el"
	einfo "Copy ${GAMES_DATADIR}/${PN}/el.ini to ~/.elc/"
	einfo "to make per-user changes."
	echo
}
