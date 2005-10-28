# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-rpg/eternal-lands/eternal-lands-1.1.2.ebuild,v 1.3 2005/10/28 14:34:38 wolf31o2 Exp $

inherit games

MY_PV=${PV%_p*}
DESCRIPTION="An online MMORPG written in C and SDL"
HOMEPAGE="http://www.eternal-lands.com"
SRC_URI="http://el.tfm.ro/el_${MY_PV//.}_linux.zip
	ftp://ftp.berlios.de/pub/elc/elc_${MY_PV//.}.tgz
	mapeditor? ( ftp://ftp.berlios.de/pub/elc/mapedit_${MY_PV//.}.tgz )
	!nomusic? ( http://el.tfm.ro/el_music_101.zip )"

LICENSE="eternal_lands"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc mapeditor nomusic"

RDEPEND="virtual/x11
	virtual/opengl
	>=media-libs/libsdl-1.2.5
	>=media-libs/sdl-net-1.2.5
	<media-libs/openal-20051024
	!>=media-libs/openal-20051024
	!media-libs/alut
	media-libs/libvorbis
	>=dev-libs/libxml2-2.6.7
	=media-libs/cal3d-0.10.0
	>=media-libs/libpng-1.2.8
	mapeditor? ( >=x11-libs/gtk+-2.4 )"

DEPEND="${RDEPEND}
	app-arch/unzip
	doc? ( >=app-doc/doxygen-1.3.8
		>=media-gfx/graphviz-1.10 )"

src_unpack() {
	OPTIONS="OPTIONS=-DDATA_DIR="\\\\\"${GAMES_DATADIR}/${PN}/\\\\\"""
	S_CLIENT="${WORKDIR}/elc"
	S_MAPEDITOR="${WORKDIR}/map_editor"
	BROWSER="mozilla"

	unpack ${A}
	use amd64 && OPTIONS="${OPTIONS} -DX86_64"
	cd "${S_CLIENT}"
	sed \
		-e "s@CFLAGS=\$(PLATFORM) \$(CWARN) -O -ggdb -pipe@CFLAGS=${CFLAGS} @g"\
		-e "s@CXXFLAGS=\$(PLATFORM) \$(CXXWARN) -O -ggdb -pipe@CXXFLAGS=${CXXFLAGS} @g"\
		-e "s@OPTIONS=@${OPTIONS} @g" \
		Makefile.linux > Makefile \
		|| die "sed failed"
	sed \
		-e 's/#browser/browser/g' \
		-e "s/browser = mozilla/#browser = ${BROWSER}/g" \
		-e "s@#data_dir = /usr/local/games/el/@#data_dir = ${GAMES_DATADIR}/${PN}/@g" \
		el.ini > ../el.ini \
		|| die "sed failed"
	if use mapeditor; then
		cd "${S_MAPEDITOR}"
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
	cd "${WORKDIR}"
	cp license.txt EULA || die "cp failed"
	cp -r "${S_CLIENT}"/languages .
}

src_compile() {
	cd "${S_CLIENT}"
	emake || die "emake failed"
	cp el.x86.linux.bin ../el.x86.linux.bin || die "cp failed"
	if use doc; then
		emake docs || die "Failed to create documentation, try with USE=-doc"
		mv ./docs/html/ ../client || die "Failed to move documentation directory"
	fi
	if use mapeditor; then
		cd "${S_MAPEDITOR}"
		emake || die "emake failed"
		cp mapedit.x86.linux.bin ../mapedit.x86.linux.bin || die "cp failed"
	fi
}

src_install() {
	cd "${WORKDIR}"

	newgamesbin el.x86.linux.bin el || die "newgamesbin failed"
	newicon el_icon.png ${PN}.png || die "newicon failed"
	make_desktop_entry el "Eternal Lands"
	dodoc EULA
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r 2dobjects 3dobjects languages maps particles sound textures tiles \
		meshes animations actor_defs books skeletons \
		*.ini entrable.lst harvestable.lst \
		global_filters.txt e3dlist.txt \
		|| die "doins failed"

	if use mapeditor; then
		newgamesbin mapedit.x86.linux.bin el-mapedit || die "newgamesbin failed"
		doins -r browser.lst mapeditor || die "doins failed"
		dohtml -r "${WORKDIR}/mapeditor" || die
		make_desktop_entry el-mapedit "Map editor"
	fi
	if ! use nomusic ; then
		doins -r music/ || die "doins failed"
	fi

	if use doc ; then
		dohtml -r "${WORKDIR}/client/"*
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "To run the game: el"
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
