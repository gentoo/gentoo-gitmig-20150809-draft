# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/prboom/prboom-2.2.4-r1.ebuild,v 1.2 2004/07/21 18:33:55 dholm Exp $

inherit games eutils gcc

DESCRIPTION="Port of ID's doom to SDL and OpenGL"
HOMEPAGE="http://prboom.sourceforge.net/"
SRC_URI="mirror://sourceforge/prboom/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"
IUSE="opengl"

DEPEND="virtual/x11
	>=media-libs/libsdl-1.1.3
	media-libs/sdl-mixer
	media-libs/sdl-net
	media-libs/smpeg
	opengl? ( virtual/opengl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-gcc34.patch
	ebegin "Detecting NVidia GL/prboom bug"
	$(gcc-getCC) ${FILESDIR}/${PV}-nvidia-test.c 2> /dev/null
	local ret=$?
	eend ${ret} "NVidia GL/prboom bug found ;("
	[ ${ret} -eq 0 ] || epatch ${FILESDIR}/${PV}-nvidia.patch
}

src_compile() {
	# leave --disable-cpu-opt in otherwise the configure script
	# will append -march=i686 and crap ... let the user's CFLAGS
	# handle this ...
	egamesconf \
		`use_enable opengl gl` \
		`use_enable x86 i386-asm` \
		--disable-cpu-opt \
		|| die
	# configure script screws up a few things
	sed -i "/DOOMWADDIR/s:\".*\":\"${GAMES_DATADIR}/doom-data\":" config.h
	use opengl || sed -i '/GL_DOOM/s:.*::' config.h
	emake || die
}

src_install() {
	dogamesbin src/prboom{,-game-server} || die

	insinto ${GAMES_DATADIR}/doom-data
	doins data/*.wad || die

	doman doc/*.{5,6}
	dodoc AUTHORS ChangeLog NEWS README TODO doc/README.* doc/*.txt

	prepgamesdirs
}
