# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-190.ebuild,v 1.1 2003/09/09 18:10:14 vapier Exp $

inherit games

DESCRIPTION="America's Army: Operations - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="ftp://armyops:ftp@guinness.devrandom.net:7000/armyops${PV}-linux.bin
	ftp://armyops:ftp@2dollar.unixwhore.com:69/armyops${PV}-linux.bin
	http://www.biot.com/misc/armyops${PV}-linux.bin"

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
	ewarn "The installed game takes about 1.3GB of space!"
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

	tar -jxf armyops${PV}.tar.bz2 -C ${D}/${dir}/ || die

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
