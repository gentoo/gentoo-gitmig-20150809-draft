# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/stella/stella-1.2.ebuild,v 1.2 2004/02/03 21:46:25 mr_bones_ Exp $

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/stella/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="sdl oss X"

DEPEND="|| (
		X? ( virtual/x11 )
		sdl? ( media-libs/libsdl )
		virtual/x11
	)"

src_compile() {
	if [ `use X` ] || [ -z "`use X``use sdl`" ] ; then
		cd ${S}/src/build
		emake OPTIMIZATIONS="${CFLAGS}" linux-x || die
	fi
	if [ `use sdl` ] ; then
		cd ${S}/src/build
		emake OPTIMIZATIONS="${CFLAGS}" linux-sdl || die
	fi

	if [ `use oss` ] ; then
		cd ${S}/src/ui/sound
		emake CC="${CC} ${CFLAGS}" linux || die
	fi
}

src_install() {
	use X && dobin src/build/stella.x11
	use sdl && dobin src/build/stella.sdl
	[ -z "`use X``use sdl`" ] && dobin src/build/stella.x11
	use oss && dobin src/ui/sound/stella-sound

	insinto /etc
	doins src/stellarc

	dohtml -r docs/
	dodoc *.txt
}
