# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands/eternal-lands-1.0.1.ebuild,v 1.1 2005/01/28 19:59:14 mr_bones_ Exp $

inherit games

TMP_PV=${PV%_p*}
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://el.tfm.ro/el_${TMP_PV//.}.zip
	ftp://ftp.berlios.de/pub/elc/elc_${PV//.}.tgz
	mapeditor? ( ftp://ftp.berlios.de/pub/elc/mapedit_${PV//.}.tgz )
	!nomusic? ( http://el.tfm.ro/el_music_${PV//.}.zip )"

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nomusic mapeditor"

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.5
	>media-libs/openal-20020127
	media-libs/libvorbis
	>=dev-libs/libxml2-2.6.7
	mapeditor? ( <x11-libs/gtk+-1.3 )"

DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( >=app-doc/doxygen-1.3.8
		>=media-gfx/graphviz-1.10)"

src_unpack() {
	OPTIONS="OPTIONS=-DDATA_DIR="\\\\\"${GAMES_DATADIR}/${PN}/\\\\\"" "
	S_CLIENT="${WORKDIR}/elc"
	S_MAPEDITOR="${WORKDIR}/map_editor"

	unpack ${A}
	use amd64 && OPTIONS="${OPTIONS} -DX86_64"
	cd "${S_CLIENT}"
	sed \
		-e "s@CFLAGS=\$(PLATFORM) -Wall -O -Werror -ggdb -pipe @CFLAGS=${CFLAGS} @g" \
		-e "s@OPTIONS=@${OPTIONS} @g" \
		Makefile.linux > Makefile \
		|| die "sed failed"
	sed \
		-e 's/#browser/browser/g' \
		-e 's/browser = mozilla/#browser = mozilla/g' \
		-e "s@#data_dir = /usr/local/games/el/@#data_dir = ${GAMES_DATADIR}/${PN}/@g" \
		el.ini > ../el.ini \
		|| die "sed failed"
	if use mapeditor; then
		cd ${S_MAPEDITOR}
		sed \
			-e "s@CFLAGS=@CFLAGS=${CFLAGS} @g" \
			-e "s@OPTIONS=@${OPTIONS} @g" \
			Makefile.linux > Makefile \
			|| die "sed failed"
		sed \
			-e "s@#data_dir = /usr/local/games/el/@#data_dir = ${GAMES_DATADIR}/${PN}/@g" \
			mapedit.ini > ../mapedit.ini \
			|| die "sed failed"
		mv browser.lst ../browser.lst
	fi
	cd ${WORKDIR}
	cp license.txt EULA || die "cp failed"
	cp changes.txt ChangeLog || die "cp failed"
}

src_compile() {
	cd ${S_CLIENT}
	emake || die "emake failed"
	cp el.x86.linux.bin ../el.x86.linux.bin || die "cp failed"
	if use doc; then
		emake docs || die "Failed to create documentation, try with USE=-docs"
		mv ./docs/html/ ../client || die "Failed to move documentation directory"
	fi
	if use mapeditor; then
		cd ${S_MAPEDITOR}
		emake || die "emake failed"
		cp mapedit.x86.linux.bin ../mapedit.x86.linux.bin || die "cp failed"
	fi
}

src_install () {
	cd "${WORKDIR}"
	newgamesbin el.x86.linux.bin el || die "newgamesbin failed"
	if use mapeditor; then
		newgamesbin mapedit.x86.linux.bin el-mapedit \
			|| die "newgamesbin failed"
	fi

	dodoc ChangeLog EULA
	insinto "${GAMES_DATADIR}/${PN}"
	doins *.ini entrable.lst harvestable.lst el_icon.png icon.bmp \
		global_filters.txt local_ignores.txt e3dlist.txt \
		|| die "doins failed"

	if use mapeditor; then
		doins browser.lst || die "doins failed"
	fi

	cp -R 2dobjects 3dobjects languages maps md2 particles sound textures tiles \
		"${D}/${GAMES_DATADIR}/${PN}" \
		|| die "copy failed"

	if ! use nomusic; then
		cp -R music "${D}/${GAMES_DATADIR}/${PN}" || die "cp failed"
	fi

	if use doc; then
		dohtml -r "${WORKDIR}/client/"*
	fi
	if use mapeditor; then
		dohtml "${WORKDIR}/mapeditor.html"
		dohtml -r "${WORKDIR}/mapeditor"
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To run the game: el"
	einfo "Copy ${GAMES_DATADIR}/${PN}/el.ini to ~/.elc/"
	einfo "to make per-user changes."
	echo
	if use mapeditor; then
		einfo "To use the map editor: el-mapedit"
		einfo "Copy ${GAMES_DATADIR}/${PN}/mapedit.ini to ~/.elc/"
		einfo "to make per-user changes."
		echo
		einfo "To read an introduction to the map editor, read"
		einfo "/usr/share/doc/${PF}/html/mapeditor.html"
		echo
	fi
	if use doc; then
		einfo "The documentation for the client source can be found"
		einfo "in /usr/share/doc/${PF}/html/index.html"
		echo
	fi
}
