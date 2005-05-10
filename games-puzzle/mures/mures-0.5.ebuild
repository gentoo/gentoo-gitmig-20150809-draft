# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/mures/mures-0.5.ebuild,v 1.2 2005/05/10 20:00:57 wolf31o2 Exp $

inherit eutils games

DESCRIPTION="A clone of Sega's Chu Chu Rocket"
HOMEPAGE="http://mures.sourceforge.net/"
SRC_URI="mirror://sourceforge/mures/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="opengl"

DEPEND="media-libs/libsdl
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-ttf
	opengl? ( virtual/opengl )"

dir="${GAMES_DATADIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Disable OpenGL support if USE flag is not set
	if use !opengl ; then
		einfo "Disabling OpenGL"
		sed -i \
			-e 's: -DHAVE_GL::' \
			-e 's: -lGL::' \
			configure.in || die "sed configure.in failed"
		sed -i -e 's:./configure \$\*::' \
			autogen.sh || die "sed autogen.sh failed"
	fi

	cd src

	# Apply savegame patch. Game will be saved in ~/saved.mus
	epatch ${FILESDIR}/${P}-save.patch

	# Apply screenshot save patch. It will be saved as ~/mures_shot.bmp
	epatch ${FILESDIR}/${P}-screenshot.patch

	# Modify game data & scrips path
	sed -i \
		-e "s:gui/:${dir}/gui/:" \
		-e "s:sounds/:${dir}/sounds/:" \
		gui.c || die "sed gui.c failed"
	sed -i \
		-e "s:images/:${dir}/images/:" \
		-e "s:textures/:${dir}/textures/:" \
		go_sdl.c || die "sed go_sdl.c failed"
	sed -i \
		-e "s:textures/:${dir}/textures/:" \
		go_gl.c || die "sed go_gl.c failed"
	sed -i \
		-e "s:input.lua:${dir}/input.lua:" \
		gi_sdl.c || die "sed gi_sdl.c failed"
	sed -i \
		-e "s:images/:${dir}/images/:" \
		anim.c output.c || die "sed anim.c output.c failed"
	sed -i \
		-e "s:maps/:${dir}/maps/:" \
		load_maps.lua || die "sed load_maps.lua failed"
	sed -i \
		-e "s:sounds/:${dir}/sounds/:" \
		audio_sdl.c || die "sed audio_sdl.c failed"
	sed -i \
		-e "s:load_maps.lua:${dir}/load_maps.lua:" \
		map.c || die "sed map.c failed"
}

src_compile() {
	if use !opengl ; then
		./autogen.sh
	fi
	egamesconf || die "egamesconf failed"
	emake || die "emake failed"
}

src_install() {
	# Remove makefiles before installation
	rm -f src/*/Makefile* src/*/*/Makefile* || die "removing makefiles"
	insinto ${dir}
	doins -r src/gui src/images src/sounds src/textures src/maps src/*.lua \
		|| die "copying data files"
	dodoc README TODO ChangeLog AUTHORS || die "dodoc failed"
	dogamesbin src/mures || die "dogamesbin failed"

	prepgamesdirs
}
