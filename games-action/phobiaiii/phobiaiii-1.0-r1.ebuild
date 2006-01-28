# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/phobiaiii/phobiaiii-1.0-r1.ebuild,v 1.5 2006/01/28 21:19:10 joshuabaergen Exp $

inherit games

DESCRIPTION="Just a moment ago, you were safe inside your ship, behind five inch armour"
HOMEPAGE="http://www.lynxlabs.com/phobiaIII/"
SRC_URI="ftp://ftp.edome.net/demot/actionpelit/phobia3-linux.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="kde-base/arts
	media-sound/esound
	media-libs/audiofile
	media-libs/sdl-mixer
	|| ( x11-libs/libXext virtual/x11 )
	media-libs/libvorbis
	media-libs/libogg
	>=sys-libs/lib-compat-1.3
	media-libs/libsdl
	media-libs/smpeg"

S=${WORKDIR}/phobia3

src_install() {
	dodoc README
	rm -rf README src

	dodir ${GAMES_PREFIX_OPT}/${PN}
	mv * ${D}/${GAMES_PREFIX_OPT}/${PN}/

	dogamesbin ${FILESDIR}/phobiaIII
	if has_version '<sys-libs/glibc-2.3.2' ; then
		dosed '/LD_PRELOAD/s:.*::' ${GAMES_BINDIR}/phobiaIII
	fi

	prepgamesdirs
}
