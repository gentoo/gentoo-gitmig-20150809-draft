# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/imaze/imaze-1.4.ebuild,v 1.15 2008/12/02 20:11:57 ssuominen Exp $

inherit games

DESCRIPTION="Multi player, real time, 3D, labyrinth, run & shoot game"
HOMEPAGE="http://home.tu-clausthal.de/student/iMaze/"
SRC_URI="http://home.tu-clausthal.de/student/iMaze/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="joystick"

RDEPEND="x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXt
	x11-libs/Xaw3d"
DEPEND="${RDEPEND}
	x11-proto/xproto"

S=${WORKDIR}/${P}/source

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e s:'DEFINES=-DDEFAULT_SOUND_DIR=\\"`pwd`/../sounds\\"':\
'DEFINES=-DDEFAULT_SERVER=\\"localhost\\" -DDEFAULT_SOUND_DIR=\\"${GAMES_DATADIR}/${PN}/sounds\\"': Makefile.in \
		|| die "sed failed"
}

src_compile() {
	local myconf="audio athena"

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
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ../labs/ ../sounds/ || die "doins failed"
	prepgamesdirs
}
