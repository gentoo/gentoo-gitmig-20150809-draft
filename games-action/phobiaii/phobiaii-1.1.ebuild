# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/phobiaii/phobiaii-1.1.ebuild,v 1.3 2004/01/12 06:35:49 vapier Exp $

inherit games

MY_P="linuxphobia-${PV}"
DESCRIPTION="Just a moment ago, you were safe inside your ship, behind five inch armour"
HOMEPAGE="http://www.lynxlabs.com/games/linuxphobia/index.html"
SRC_URI="http://www.lynxlabs.com/games/linuxphobia/${MY_P}-i386.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND=""
RDEPEND="media-libs/sdl-mixer
	media-libs/libsdl
	sys-libs/lib-compat
	virtual/glibc"

S=${WORKDIR}/${MY_P}

src_install() {
	dodoc README
	rm setup-link.sh README

	dodir ${GAMES_PREFIX_OPT}/${PN}
	mv * ${D}/${GAMES_PREFIX_OPT}/${PN}/

	dogamesbin ${FILESDIR}/phobiaII

	prepgamesdirs
}
