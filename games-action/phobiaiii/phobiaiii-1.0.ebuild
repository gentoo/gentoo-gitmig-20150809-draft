# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/phobiaiii/phobiaiii-1.0.ebuild,v 1.1 2003/09/10 19:29:16 vapier Exp $

inherit games

MY_P="phobia3"
DESCRIPTION="Just a moment ago, you were safe inside your ship, behind five inch armour"
HOMEPAGE="http://www.lynxlabs.com/phobiaIII/"
SRC_URI="ftp://ftp.edome.net/demot/actionpelit/${MY_P}-linux.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND=""
RDEPEND="kde-base/arts
	media-sound/esound
	media-libs/audiofile
	media-libs/sdl-mixer
	virtual/x11
	media-libs/libvorbis
	media-libs/libogg
	media-libs/smpeg
	media-libs/libsdl
	dev-libs/DirectFB
	media-libs/libggi
	media-libs/libgii
	sys-libs/lib-compat
	media-libs/nas
	media-libs/svgalib
	media-libs/aalib
	sys-libs/ncurses"

S=${WORKDIR}/${MY_P}

src_install() {
	dodoc README
	rm -rf README src

	dodir ${GAMES_PREFIX_OPT}/${PN}
	mv * ${D}/${GAMES_PREFIX_OPT}/${PN}/

	dogamesbin ${FILESDIR}/playphobiaIII

	prepgamesdirs
}
