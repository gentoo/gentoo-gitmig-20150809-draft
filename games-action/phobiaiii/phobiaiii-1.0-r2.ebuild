# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/phobiaiii/phobiaiii-1.0-r2.ebuild,v 1.5 2006/09/15 19:25:35 wolf31o2 Exp $

inherit games

DESCRIPTION="Just a moment ago, you were safe inside your ship, behind five inch armour"
HOMEPAGE="http://www.lynxlabs.com/phobiaIII/"
SRC_URI="ftp://ftp.edome.net/demot/actionpelit/phobia3-linux.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="strip"

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

src_unpack() {
	unpack ${A}
	rm -rf "${S}/src"
}

src_install() {
	dogamesbin "${FILESDIR}/phobiaIII" || die "dogamesbin failed"
	dosed ":GAMES_PREFIX_OPT:${GAMES_PREFIX_OPT}:" \
		${GAMES_BINDIR}/phobiaIII || die "sed"
	if has_version '<sys-libs/glibc-2.3.2' ; then
		dosed '/LD_PRELOAD/s:.*::' "${GAMES_BINDIR}/phobiaIII"
	fi
	dodir "${GAMES_PREFIX_OPT}/${PN}"
	cp -r [a-z]* "${D}/${GAMES_PREFIX_OPT}/${PN}/" || die "cp failed"
	dodoc README

	prepgamesdirs
	# wants to write hiscores and config to this directory.
	fperms 2770 "${GAMES_PREFIX_OPT}/${PN}/dat"
}
