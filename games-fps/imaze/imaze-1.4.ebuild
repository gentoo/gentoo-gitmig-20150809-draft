# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/imaze/imaze-1.4.ebuild,v 1.6 2004/11/11 19:41:25 wolf31o2 Exp $

inherit games

DESCRIPTION="Multi player, real time, 3D, labyrinth, run & shoot game"
HOMEPAGE="http://home.tu-clausthal.de/student/iMaze/"
SRC_URI="http://home.tu-clausthal.de/student/iMaze/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="Xaw3d joystick"

RDEPEND="virtual/x11
	virtual/libc
	|| (
		Xaw3d? ( x11-libs/Xaw3d )
		x11-libs/xview
	)"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${P}/source"

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
