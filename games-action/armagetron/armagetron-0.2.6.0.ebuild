# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetron/armagetron-0.2.6.0.ebuild,v 1.7 2004/12/07 09:32:13 mr_bones_ Exp $

inherit games flag-o-matic

DESCRIPTION="3d tron lightcycles, just like the movie"
HOMEPAGE="http://armagetron.sourceforge.net/"
SRC_URI="mirror://sourceforge/armagetron/${P}.tar.bz2
	http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
	http://armagetron.sourceforge.net/addons/moviepack.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack() {
	unpack ${A}
	set > /tmp/emerge-env.txt
	cd "${S}"
	# Uses $SYNC which which conflicts with emerge
	sed -i \
		-e 's/$(SYNC)/$(SYNCDISK)/' Makefile.global.in \
		|| die 'sed Makefile.global.in failed'
	filter-flags -fno-exceptions
}

src_install() {
	# make install for armagetron is non-existant
	dodir "${GAMES_LIBDIR}/${PN}" "${GAMES_DATADIR}/${PN}" /usr/share/fonts
	cp src/tron/armagetron "${D}/${GAMES_LIBDIR}/${PN}" \
		|| die "cp failed"
	cp -r arenas models sound textures language config \
		"${D}/${GAMES_DATADIR}/${PN}/" \
		|| die "cp failed"
	# maybe convert this to a .png or something
	#cp tron.ico ${D}/${GAMES_DATADIR}/${PN}
	dohtml doc
	newgamesbin "${FILESDIR}/${PN}-0.2.4-r1.sh" ${PN} \
		|| die "newgamesbin failed"
	sed -i \
		-e "s:DATADIR:${GAMES_DATADIR}/${PN}:" \
		-e "s:BINDIR:${GAMES_LIBDIR}/${PN}:" "${D}${GAMES_BINDIR}/${PN}" \
		|| die "sed failed"
	cp -r ../moviepack "${D}/${GAMES_DATADIR}/${PN}" || die "cp failed"
	cp -r ../moviesounds "${D}/${GAMES_DATADIR}/${PN}" || die "cp failed"
	prepgamesdirs
}
