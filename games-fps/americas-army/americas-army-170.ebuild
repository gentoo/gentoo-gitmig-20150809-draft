# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-170.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

DESCRIPTION="America's Army: Operations - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="ftp://ftp.stenstad.net/mirrors/icculus.org/armyops-lnx-${PV}.sh.bin
	http://guinness.devrandom.net/%7Eprimus/armyops-lnx-${PV}.sh.bin
	http://www.3ddownloads.com/linuxgames/americas_army/armyops-lnx-${PV}.sh.bin"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="media-sound/esound
	virtual/x11
	virtual/opengl"

S=${WORKDIR}

pkg_setup() {
	ewarn "The installed game takes about 850MB of space!"
	games_pkg_setup
}

src_unpack() {
	unpack_makeself || die
	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	tar -jxf armyops${PV}System.tar.bz2 -C ${D}/${dir}/ || die
	tar -jxf armyops${PV}data.tar.bz2 -C ${D}/${dir}/ || die

	dodoc README.linux
	insinto ${dir} ; doins ArmyOps.xpm
	insinto /usr/share/pixmaps ; doins ArmyOps.xpm
	exeinto ${dir} ; doexe bin/armyops

	sed -e "s:GENTOO_DIR:${dir}:" ${FILESDIR}/armyops > armyops
	dogamesbin armyops
	dosym ${dir}/armyops ${GAMES_BINDIR}/armyops

	prepgamesdirs
	make_desktop_entry armyops "AA: Operations" ArmyOps.xpm

}

pkg_postinst() {
	einfo "To play the game run:"
	einfo " armyops"

	games_pkg_postinst
}
