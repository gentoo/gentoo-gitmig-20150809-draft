# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/prboom/prboom-2.2.3.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games eutils

DESCRIPTION="Port of ID's doom to SDL and OpenGL"
HOMEPAGE="http://prboom.sourceforge.net/"
SRC_URI="mirror://sourceforge/prboom/${P}.tar.gz
	http://www.lbjhs.net/~jessh/lsdldoom/doom1.wad.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
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
	ebegin "Detecting NVidia GL/prboom bug"
	gcc ${FILESDIR}/${PV}-nvidia-test.c 2> /dev/null
	eend $? "NVidia GL/prboom bug found ;("
	epatch ${FILESDIR}/${PV}-nvidia.patch
}

src_compile() {
	egamesconf `use_enable opengl gl` || die
	emake || die
}

src_install() {
	dogamesbin src/prboom{,-game-server}

	insinto ${GAMES_DATADIR}/doom/
	doins ../doom1.wad data/*.wad

	doman doc/*.{5,6}
	dodoc AUTHORS ChangeLog NEWS README TODO doc/README.* doc/*.txt

	prepgamesdirs
}
