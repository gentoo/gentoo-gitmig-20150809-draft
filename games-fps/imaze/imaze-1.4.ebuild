# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/imaze/imaze-1.4.ebuild,v 1.2 2004/03/21 13:45:20 dholm Exp $

inherit games

S="${WORKDIR}/${P}/source"
DESCRIPTION="Multi player, real time, 3D, labyrinth, run & shoot game"
HOMEPAGE="http://home.tu-clausthal.de/student/iMaze/"
SRC_URI="http://home.tu-clausthal.de/student/iMaze/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="X Xaw3d joystick"

RDEPEND="virtual/x11
	virtual/glibc
	|| (
		Xaw3d? ( x11-libs/Xaw3d )
		x11-libs/xview
	)"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e s:'DEFINES=-DDEFAULT_SOUND_DIR=\\"`pwd`/../sounds\\"':\
'DEFINES=-DDEFAULT_SERVER=\\"localhost\\" -DDEFAULT_SOUND_DIR=\\"${GAMES_DATADIR}/${PN}/sounds\\"': Makefile.in \
		|| die "src_unpack failed"
}

src_compile() {
	local myconf="audio"

	use Xaw3d \
		&& myconf="${myconf} athena" \
		|| myconf="${myconf} xview"

	use joystick \
		&& myconf="${myconf} joystick" \
		|| myconf="${myconf} nojoystick"

	# not an autoconf script.
	./configure ${myconf} || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	dogamesbin genlab imaze imazesrv imazestat ninja xlabed \
		|| die "dogamesbin failed"
	dodoc ../README
	doman ../man6/*6
	dodir "${GAMES_DATADIR}/${PN}"
	cp -r ../labs/ ../sounds/ "${D}${GAMES_DATADIR}/${PN}/"
	prepgamesdirs
}
