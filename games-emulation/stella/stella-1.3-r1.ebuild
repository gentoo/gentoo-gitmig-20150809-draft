# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/stella/stella-1.3-r1.ebuild,v 1.8 2005/02/24 02:21:05 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Stella Atari 2600 VCS Emulator"
HOMEPAGE="http://stella.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="sdl X alsa"

DEPEND="|| (
		X? ( virtual/x11 )
		sdl? ( media-libs/libsdl )
		virtual/x11
	)
	alsa? ( media-libs/alsa-lib )
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-alsa-fix.patch"
}

src_compile() {
	# let's just default joystick & snapshot support to on
	MYOPTS="JOYSTICK_SUPPORT=1 SNAPSHOT_SUPPORT=1"

	if use alsa ; then
		MYOPTS="${MYOPTS} SOUND_ALSA=1"
	fi
	if use X || ! use sdl ; then
		cd ${S}/src/build
		emake OPTIMIZATIONS="${CFLAGS}" $MYOPTS linux-x \
			|| die "emake failed"
	fi
	if use sdl ; then
		cd ${S}/src/build
		emake OPTIMIZATIONS="${CFLAGS}" $MYOPTS SOUND_SDL=1 linux-sdl \
			|| die "emake failed"
	fi
}

src_install() {
	if use X || ! use sdl ; then
		dobin src/build/stella.x11 || die "dobin failed"
	fi
	if use sdl ; then
		dobin src/build/stella.sdl || die "dobin failed"
	fi

	insinto /etc
	doins src/stellarc src/emucore/stella.pro

	dohtml -r docs/
	dodoc *.txt
}
