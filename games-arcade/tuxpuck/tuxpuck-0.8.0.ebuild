# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxpuck/tuxpuck-0.8.0.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

DESCRIPTION="Hover hockey"
SRC_URI="http://www.efd.lth.se/~d00jkr/tuxpuck/${P}.tar.gz"
HOMEPAGE="http://www.efd.lth.se/~d00jkr/tuxpuck/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/libpng
	>=media-libs/libvorbis-1.0_rc3"
RDEPEND="$DEPEND"

src_compile() {
	export CPP_FLAGS="${CPPFLAGS} -I/usr/include/libpng12"
	make || die
}

src_install() {
	dobin tuxpuck
	doman man/tuxpuck.6
	dodoc COPYING *.txt
}
