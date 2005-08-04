# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetron/armagetron-0.2.6.1.ebuild,v 1.2 2005/08/04 08:04:37 blubb Exp $

inherit flag-o-matic eutils games

DESCRIPTION="3d tron lightcycles, just like the movie"
HOMEPAGE="http://armagetron.sourceforge.net/"
SRC_URI="mirror://sourceforge/armagetron/${P}.tar.bz2
	http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
	http://armagetron.sourceforge.net/addons/moviepack.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_compile() {
	#	$(use_enable !dedicated glout)
	egamesconf \
		--enable-music \
		|| die
	emake || die
}

src_install() {
	dogamesbin src/network/astat || die "astat failed"
	exeinto "${GAMES_LIBDIR}"/${PN}
	doexe src/tron/armagetron || die "armagetron failed"

	insinto "${GAMES_DATADIR}"/${PN}
	doins -r arenas config language models music sound textures || die "doins data"
	doins -r ../movie{pack,sounds} || die "doins movie data"
	dohtml -r doc/*

	newgamesbin "${FILESDIR}"/${PN}-0.2.6.1.sh armagetron
	sed -i \
		-e "s:DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:LIBDIR:${GAMES_LIBDIR}/${PN}:" \
		"${D}/${GAMES_BINDIR}"/armagetron \
		|| die "sed failed"
	prepgamesdirs
}
