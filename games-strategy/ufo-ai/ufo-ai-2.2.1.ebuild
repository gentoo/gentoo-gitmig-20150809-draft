# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/ufo-ai/ufo-ai-2.2.1.ebuild,v 1.1 2008/10/04 19:46:06 tupone Exp $

inherit eutils autotools games

MY_P="${P/o-a/oa}"

DESCRIPTION="UFO: Alien Invasion - X-COM inspired strategy game"
HOMEPAGE="http://ufoai.sourceforge.net/"
SRC_URI="mirror://sourceforge/ufoai/${MY_P}-source.tar.bz2
	mirror://sourceforge/ufoai/${MY_P}-data.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated doc editor mmx"

# Dependencies and more instructions can be found here:
# http://ufoai.ninex.info/wiki/index.php/Compile_for_Linux
RDEPEND="!dedicated? (
		virtual/opengl
		virtual/glu
		media-libs/libsdl
		media-libs/sdl-ttf
		media-libs/sdl-mixer
		media-libs/jpeg
		media-libs/libpng
		media-libs/libogg
		media-libs/libvorbis
		x11-proto/xf86vidmodeproto
	)
	editor? ( media-libs/jpeg )
	net-misc/curl
	sys-devel/gettext"

DEPEND="${RDEPEND}
	doc? ( virtual/latex-base )"

S=${WORKDIR}/${MY_P}-source

src_unpack() {
	unpack ${A}
	cd "${S}"
	# move data from packages to source dir
	mv "${WORKDIR}/base" "${S}"

	# Set basedir & fixes bug in finding text files - it should use fs_basedir
	epatch "${FILESDIR}"/${P}-gentoo.patch

	sed -i \
		-e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" \
		src/common/files.c \
		src/tools/gtkradiant/games/ufoai.game \
		src/client/cl_main.c \
		src/client/cl_language.c \
		|| die "sed failed"
}

src_compile() {
	egamesconf \
		$(use_enable mmx) \
		--enable-release \
		$(use_enable editor ufo2map) \
		--enable-dedicated \
		$(use_enable !dedicated client) \
		--with-shaders

	emake lang || die "emake langs failed"

	if use doc ; then
		emake pdf-manual || die "emake pdf-manual failed (USE=doc)"
	fi

	emake || die "emake failed"
}

src_install() {
	# server
	dogamesbin ufoded || die "Failed installing server"
	newicon src/ports/linux/installer/data/ufo.xpm ${PN}.xpm \
		|| die "Failed installing icon"
	make_desktop_entry ${PN}-ded "UFO: Alien Invasion Server" ${PN}.xpm
	if ! use dedicated ; then
		# client
		newgamesbin ufo ${PN} || die "Failed installing client"
		make_desktop_entry ${PN} "UFO: Alien Invasion" ${PN}.xpm
	fi

	if use editor ; then
		dogamesbin ufo2map || die "Failed installing editor"
	fi

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r base || die "doins -r failed"
	if use doc ; then
		dodoc src/docs/tex/ufo-manual_EN.pdf || die "Failed installing manual"
	fi

	prepgamesdirs
}
