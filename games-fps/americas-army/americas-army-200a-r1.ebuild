# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-200a-r1.ebuild,v 1.1 2004/04/02 03:58:11 wolf31o2 Exp $

inherit games

MY_P="armyops200a-linux.bin"
DESCRIPTION="America's Army: Operations - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="ftp://3dgamers.in-span.net/pub/3dgamers4/games/${PN/-/}/${MY_P}
	http://3dgamers.reliableservers.net/pub/3dgamers/games/${PN/-/}/${MY_P}
	http://3dgamers.gameservers.net/pub/3dgamers/games/${PN/-/}/${MY_P}
	http://3dgamers.planetmirror.com/pub/3dgamers/games/${PN/-/}/${MY_P}
	http://download.factoryunreal.com/mirror/UT2003CrashFix.zip"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="x86"
RESTRICT="nostrip nomirror"

# dedicated is unused at this time until I can find some good generic dedicated
# server scripts to include.
IUSE="opengl dedicated"

DEPEND="virtual/glibc
	app-arch/unzip"
RDEPEND="virtual/glibc
	opengl? ( virtual/opengl )"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	ewarn "The installed game takes about 1.6GB of space when installed and 2.4GB of space in ${PORTAGE_TMPDIR} to build!"
}

src_unpack() {
	unpack_makeself ${DISTDIR}/${MY_P} || die "unpacking game"
	unzip ${DISTDIR}/UT2003CrashFix.zip \
		|| die "unpacking crash-fix"
	tar -zxf setupstuff.tar.gz || die
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	local dir=${GAMES_PREFIX_OPT}/${PN}
	dodir ${dir}

	tar -jxf armyops200a.tar.bz2 -C ${D}/${dir}/ || die "armyops untar failed"
	tar -jxf binaries.tar.bz2 -C ${D}/${dir}/ || die "binaries untar failed"

	dodoc README.linux
	insinto ${dir} ; doins ArmyOps.xpm README.linux
	insinto /usr/share/pixmaps ; doins ArmyOps.xpm
	exeinto ${dir} ; doexe bin/armyops

	dogamesbin ${FILESDIR}/armyops
	dosed "s:GENTOO_DIR:${dir}:" ${GAMES_BINDIR}/armyops
	dosym ${dir}/armyops ${GAMES_BINDIR}/armyops

	# Here we apply DrSiN's crash patch
	cp ${S}/CrashFix/System/crashfix.u ${Ddir}/System
	ed ${Ddir}/System/Default.ini >/dev/null 2>&1 <<EOT
$
?Engine.GameInfo?
a
AccessControlClass=crashfix.iaccesscontrolini
.
w
q
EOT

	prepgamesdirs
	make_desktop_entry armyops "America's Army" ArmyOps.xpm
}

pkg_postinst() {
	games_pkg_postinst
	einfo "To play the game run:"
	einfo " armyops"
	echo
	ewarn "If you are not installing for the first time and you plan on running"
	ewarn "a server, you will probably need to edit your"
	ewarn "~/.armyops200/System/UT2003.ini file and add a line that says"
	ewarn "AccessControlClass=crashfix.iaccesscontrolini to your"
	ewarn "[Engine.GameInfo] section to close a security issue."
	echo
}
