# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/imaze/imaze-1.4.ebuild,v 1.12 2006/12/05 15:24:41 wolf31o2 Exp $

inherit games

DESCRIPTION="Multi player, real time, 3D, labyrinth, run & shoot game"
HOMEPAGE="http://home.tu-clausthal.de/student/iMaze/"
SRC_URI="http://home.tu-clausthal.de/student/iMaze/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="Xaw3d joystick"

RDEPEND="
	x11-libs/libXmu
	x11-libs/libX11
	x11-libs/libXaw
	x11-libs/libXt
	|| (
		Xaw3d? ( x11-libs/Xaw3d )
		x11-libs/xview )"
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
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r ../labs/ ../sounds/ || die "doins failed"
	prepgamesdirs
}
