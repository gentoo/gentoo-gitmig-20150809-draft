# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/tuxpuck/tuxpuck-0.7.91.ebuild,v 1.1 2003/09/10 19:29:21 vapier Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Hover hockey"
SRC_URI="http://www.efd.lth.se/~d00jkr/tuxpuck/${P}.tar.gz"
HOMEPAGE="http://www.efd.lth.se/~d00jkr/tuxpuck/"

DEPEND=">=media-libs/libsdl-1.1.5
	media-libs/libpng
	>=media-libs/libvorbis-1.0_rc3"
RDEPEND="$DEPEND"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {

	export CPP_FLAGS="${CPPFLAGS} -I/usr/include/libpng12"

	# Don't treat warnings as errors
	cp Makefile Makefile.orig
	sed 's:-Werror::' < Makefile.orig > Makefile

	# Link to the system freetype, not xfree's
	cp Makefile Makefile.orig
	sed 's:-I/usr/X11R6/include/freetype2:-I/usr/include/freetype2:' \
		< Makefile.orig > Makefile

	make || die
}

src_install () {

	exeinto /usr/bin
	doexe tuxpuck
	dodoc BUGS COPYING README TODO THANKS

}
