# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxpuck/tuxpuck-0.8.2.ebuild,v 1.4 2004/06/19 17:13:05 jhuebel Exp $

inherit games

DESCRIPTION="Hover hockey"
SRC_URI="http://www.efd.lth.se/~d00jkr/tuxpuck/${P}.tar.gz"
HOMEPAGE="http://www.efd.lth.se/~d00jkr/tuxpuck/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64"
IUSE=""

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/libpng
	>=media-libs/libvorbis-1.0_rc3"

src_compile() {
	# Note that the Makefiles for tuxpuck are buggy so -j1 is used.
	emake -j1 CPP_FLAGS="${CPPFLAGS} -I/usr/include/libpng12" || die
}

src_install() {
	dogamesbin tuxpuck || die "dogamesbin failed"
	doman man/tuxpuck.6.gz
	dodoc *.txt
	prepgamesdirs
}
