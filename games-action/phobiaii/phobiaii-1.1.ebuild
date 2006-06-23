# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/phobiaii/phobiaii-1.1.ebuild,v 1.9 2006/06/23 05:15:51 mr_bones_ Exp $

inherit games

MY_P="linuxphobia-${PV}"
DESCRIPTION="Just a moment ago, you were safe inside your ship, behind five inch armour"
HOMEPAGE="http://www.lynxlabs.com/games/linuxphobia/index.html"
SRC_URI="http://www.lynxlabs.com/games/linuxphobia/${MY_P}-i386.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="media-libs/sdl-mixer
	media-libs/libsdl
	x86? ( sys-libs/lib-compat )
	amd64? ( app-emulation/emul-linux-x86-compat )
	virtual/libc"

S=${WORKDIR}/${MY_P}

src_install() {
	dodoc README
	rm setup-link.sh README

	dodir "${GAMES_PREFIX_OPT}"/${PN}
	mv * "${D}/${GAMES_PREFIX_OPT}"/${PN}/

	dogamesbin "${FILESDIR}"/phobiaII || die "dogamesbin failed"
	prepgamesdirs
}
