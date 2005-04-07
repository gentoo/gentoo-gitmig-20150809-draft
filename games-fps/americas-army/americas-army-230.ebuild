# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-230.ebuild,v 1.2 2005/04/07 20:13:26 wolf31o2 Exp $

inherit eutils games

MY_P="armyops${PV}-linux.run"
DESCRIPTION="America's Army: Special Forces - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="mirror://3dgamers/pub/3dgamers/games/${PN/-/}/${MY_P}"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="x86 amd64"
RESTRICT="nostrip nomirror"

IUSE="opengl dedicated"

DEPEND="virtual/libc
	app-arch/unzip"
RDEPEND="virtual/libc
	opengl? ( virtual/opengl )
	amd64? ( app-emulation/emul-linux-x86-xlibs
		|| ( >=media-video/nvidia-glx-1.0.6629-r3
			>=media-video/ati-drivers-8.8.25-r1
			app-emulation/emul-linux-x86-nvidia ) )
	dedicated? ( app-misc/screen )"

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

	tar -jxf armyops${PV}.tar.bz2 -C ${Ddir}/ || die "armyops untar failed"
	tar -jxf binaries.tar.bz2 -C ${Ddir}/ || die "binaries untar failed"

	dodoc README.linux
	insinto ${dir}
	doins ArmyOps.xpm README.linux ArmyOps${PV}_EULA.txt || die "doins failed"
	insinto /usr/share/pixmaps
	doins ArmyOps.xpm || die "doins failed"
	exeinto ${dir}
	doexe bin/armyops || die "doexe failed"

	if use dedicated; then
		exeinto /etc/init.d ; newexe ${FILESDIR}/armyops-ded.init armyops-ded
		insinto /etc/conf.d ; newins ${FILESDIR}/armyops-ded.conf armyops-ded
		games_make_wrapper armyops-ded ./server-bin ${dir}/System
	fi

	games_make_wrapper armyops ./armyops ${dir}

	prepgamesdirs
	make_desktop_entry armyops "America's Army" ArmyOps.xpm
}

pkg_postinst() {
	games_pkg_postinst
	if use dedicated; then
		einfo "To start a dedicated server, run"
		einfo "	/etc/init.d/armyops-ded start"
		echo
	fi
	if use opengl; then
		einfo "To play the game run:"
		einfo " armyops"
		echo
	fi
}
