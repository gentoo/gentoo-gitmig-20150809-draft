# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-200.ebuild,v 1.1 2003/11/28 15:14:19 wolf31o2 Exp $

inherit games

DESCRIPTION="America's Army: Operations - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers4/games/americasarmy/armyops${PV}-lnx.run
	ftp://theuser:9K5ya@ftp4.3dgamers.com/pub/3dgamers/games/americasarmy/armyops${PV}-lnx.run
	ftp://armyops:ftp@2dollar.unixwhore.com:69/armyops${PV}-lnx.run
	http://www.biot.com/misc/armyops${PV}-lnx.run"

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
	unpack_makeself
	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	tar -jxf armyops${PV}.tar.bz2 -C ${D}/${dir}/ || die
	tar -jxf binaries.tar.bz2 -C ${D}/${dir}/ || die

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
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " armyops"
}
