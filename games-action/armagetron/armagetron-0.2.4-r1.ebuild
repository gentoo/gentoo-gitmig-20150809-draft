# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/armagetron/armagetron-0.2.4-r1.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

IUSE="`echo " ${IUSE} " | sed 's/ dedicated //'`"
	# drop 'dedicated' as it is always enabled

S=${WORKDIR}/${PN}-${PV}
DESCRIPTION="armagetron: 3d tron lightcycles, just like the movie"
SRC_URI="mirror://sourceforge/armagetron/${P}.tar.bz2
	http://armagetron.sourceforge.net/addons/moviesounds_fq.zip
	http://armagetron.sourceforge.net/addons/moviepack.zip"

HOMEPAGE="http://armagetron.sourceforge.net/"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"
CXXFLAGS=${CXXFLAGS/-fno-exceptions/}
RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"

DEPEND="$RDEPEND app-arch/unzip"

src_unpack() {
	unpack ${PN}-${PV}.tar.bz2
	unpack moviesounds_fq.zip
	unpack moviepack.zip
	set > /tmp/emerge-env.txt
	cd ${S}
	# Uses $SYNC which which conflicts with emerge
	cp Makefile.global.in Makefile.global.in.old
	sed 's/$(SYNC)/$(SYNCDISK)/' < Makefile.global.in.old > \
		Makefile.global.in || die 'Makefile edit failed'
}

src_compile() {
	egamesconf || die "config failed"
	emake || die "Make Failed"
}

src_install () {
	# make install for armagetron is non-existant
	dodir ${GAMES_BINDIR}
	dodir ${GAMES_LIBDIR}/${PN}
	dodir ${GAMES_DATADIR}/${PN}
	dodir /usr/share/fonts
	cp src/tron/armagetron ${D}/${GAMES_LIBDIR}/${PN} || die "No Armagetron Executable"
	cp -r arenas models sound textures language config \
		${D}/${GAMES_DATADIR}/${PN}/
	# maybe convert this to a .png or something
	#cp tron.ico ${D}/${GAMES_DATADIR}/${PN}
	dohtml doc
	newgamesbin ${FILESDIR}/${P}-r1.sh ${PN}
	dosed "s:DATADIR:${GAMES_DATADIR}/${PN}:" ${GAMES_BINDIR}/${PN}
	dosed "s:BINDIR:${GAMES_LIBDIR}/${PN}:" ${GAMES_BINDIR}/${PN}
	cp -r ../moviepack ${D}/${GAMES_DATADIR}/${PN}
	cp -r ../moviesounds ${D}/${GAMES_DATADIR}/${PN}
	chmod -R a+r ${D}
	chmod a+rx ${D}/${GAMES_BINDIR}/${PN}
	chmod a+rx ${D}/${GAMES_LIBDIR}/${PN}/${PN}
}
