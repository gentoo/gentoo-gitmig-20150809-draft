# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-200a.ebuild,v 1.2 2004/02/08 22:15:24 wolf31o2 Exp $

inherit games

MY_P="armyops200a-linux.bin"
DESCRIPTION="America's Army: Operations - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers4/games/${PN}/${MY_P}
	http://3dgamers.reliableservers.net/pub/3dgamers/games/${PN}/${MY_P}
	http://3dgamers.gameservers.net/pub/3dgamers/games/${PN}/${MY_P}
	http://3dgamers.planetmirror.com/pub/3dgamers/games/${PN}/${MY_P}"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip nomirror"

DEPEND="virtual/glibc"
RDEPEND="media-sound/esound
	virtual/x11
	virtual/opengl"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	ewarn "The installed game takes about 1.6GB of space when installed and 2.4GB of space in ${PORTAGE_TMPDIR} to build!"
}

src_unpack() {
	unpack_makeself || die "Unpacking game"

	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	tar -jxf armyops200a.tar.bz2 -C ${D}/${dir}/ || die
	tar -jxf binaries.tar.bz2 -C ${D}/${dir}/ || die

	dodoc README.linux
	insinto ${dir} ; doins ArmyOps.xpm README.linux
	insinto /usr/share/pixmaps ; doins ArmyOps.xpm
	exeinto ${dir} ; doexe bin/armyops

	sed -e "s:GENTOO_DIR:${dir}:" ${FILESDIR}/armyops > armyops
	dogamesbin armyops
	dosym ${dir}/armyops ${GAMES_BINDIR}/armyops

	prepgamesdirs
	make_desktop_entry armyops "AA: Operations" ArmyOps.xpm

}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " armyops"
}
