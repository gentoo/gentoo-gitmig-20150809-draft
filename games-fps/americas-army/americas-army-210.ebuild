# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-210.ebuild,v 1.6 2004/07/19 16:41:41 augustus Exp $

inherit games

MY_P="armyops210-linux.bin"
DESCRIPTION="America's Army: Operations - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers5/games/${PN/-/}/${MY_P}
	http://3dgamers.intelenet.net/pub/3dgamers/games/${PN/-/}/${MY_P}
	http://ftp4.3dgamers.com/pub/3dgamers/games/${PN/-/}/${MY_P}
	http://3dgamers.gameservers.net/pub/3dgamers/games/${PN/-/}/${MY_P}
	http://3dgamers.planetmirror.com/pub/3dgamers/games/${PN/-/}/${MY_P}"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="x86 amd64"
RESTRICT="nostrip nomirror"

# dedicated is unused at this time until I can find some good generic dedicated
# server scripts to include.
IUSE="opengl" # dedicated

DEPEND="virtual/libc
	app-arch/unzip"
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	ewarn "The installed game takes about 1.6GB of space when installed and 2.4GB of space in ${PORTAGE_TMPDIR} to build!"
}

src_unpack() {
	unpack_makeself ${DISTDIR}/${MY_P} || die "unpacking game"
	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	dodir ${dir}

	tar -jxf armyops210.tar.bz2 -C ${Ddir}/ || die "armyops untar failed"
	tar -jxf binaries.tar.bz2 -C ${Ddir}/ || die "binaries untar failed"

	dodoc README.linux
	insinto ${dir} ; doins ArmyOps.xpm README.linux ArmyOps210_EULA.txt
	insinto /usr/share/pixmaps ; doins ArmyOps.xpm
	exeinto ${dir} ; doexe bin/armyops

	dogamesbin ${FILESDIR}/armyops
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/armyops
	dosym ${dir}/armyops ${GAMES_BINDIR}/armyops

	prepgamesdirs
	make_desktop_entry armyops "America's Army" ArmyOps.xpm
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " armyops"
	echo
}
