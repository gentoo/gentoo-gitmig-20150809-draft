# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/stella/stella-1.3.ebuild,v 1.1 2003/04/14 22:33:02 mholzer Exp $

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="sdl oss X alsa"

DEPEND="|| (
		X? ( virtual/x11 )
		sdl? ( media-libs/libsdl )
		virtual/x11
		alsa? ( media-sound/alsa-driver )
		media-libs/libpng
	)"

src_compile() {
	# let's just default joystick & snapshot support to on
	MYOPTS="JOYSTICK_SUPPORT=1 SNAPSHOT_SUPPORT=1"

	if [ `use alsa` ] ; then
		MYOPTS="${MYOPTS} SOUND_ALSA=1"
	fi
	if [ `use X` ] || [ -z "`use X``use sdl`" ] ; then
		cd ${S}/src/build
		emake OPTIMIZATIONS="${CFLAGS}" $MYOPTS linux-x || die
	fi
	if [ `use sdl` ] ; then
		cd ${S}/src/build
		emake OPTIMIZATIONS="${CFLAGS}" $MYOPTS SOUND_SDL=1 linux-sdl || die
	fi
}

src_install() {
	use X && dobin src/build/stella.x11
	use sdl && dobin src/build/stella.sdl
	[ -z "`use X``use sdl`" ] && dobin src/build/stella.x11

	insinto /etc
	doins src/stellarc
	doins src/emucore/stella.pro

	dohtml -r docs/
	dodoc *.txt
}
