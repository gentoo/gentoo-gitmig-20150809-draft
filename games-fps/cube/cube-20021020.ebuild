# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/cube/cube-20021020.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

MY_P="cube_2002_10_20"
DESCRIPTION="Landscape-style engine that pretends to be an indoor first person shooter engine"
HOMEPAGE="http://wouter.fov120.com/cube/"
SRC_URI="http://ludo.uib.no/cube/${MY_P}.zip
	http://www.idi.ntnu.no/~jonasf/cube/${MY_P}.zip
	http://tunes.org/~eihrul/${MY_P}.zip"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	sys-libs/zlib
	media-libs/libpng"
#RDEPEND=""

S=${WORKDIR}
CUBE_DATADIR=${GAMES_DATADIR}/${PN}/

src_unpack() {
	unpack ${A}

	cd source
	unzip -qn ${MY_P}_src.zip

	cd src
	patch -p0 < ${FILESDIR}/${P}-add-custom-paths.patch || die
	echo "#define GAMES_DATADIR \"${CUBE_DATADIR}\"" >> tools.h
	echo "#define GAMES_DATADIR_LEN ${#CUBE_DATADIR}" >> tools.h
	for f in sound worldio ; do
		f="${f}.cpp"
		cp ${f} ${f}.old
		sed -e "s:packages/:${CUBE_DATADIR}packages/:" ${f}.old > ${f}
	done

	for f in *.cpp ; do
		cp ${f}{,.old}
		sed -e 's/$//' ${f}.old > ${f}
	done
}

src_compile() {
	cd source/src
	make || die
}

src_install() {
	dogamesbin source/src/cube_{client,server}

	dodir ${CUBE_DATADIR}
	mv *.cfg data packages ${D}/${CUBE_DATADIR}

	dodoc source/src/CUBE_TODO.txt
	dohtml -r docs/

	prepgamesdirs
}
