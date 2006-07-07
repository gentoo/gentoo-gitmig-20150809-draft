# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-250.ebuild,v 1.11 2006/07/07 18:40:56 augustus Exp $

inherit eutils games

MY_P="armyops${PV}-linux.run"
DESCRIPTION="America's Army: Special Forces - military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="http://treefort.icculus.org/armyops/${MY_P}
	http://0day.icculus.org/armyops/${MY_P}
	mirror://3dgamers/${PN/-/}/${MY_P}
	dedicated? (
		http://dev.gentoo.org/~wolf31o2/sources/dump/${PN}-all-0.1.tar.bz2
		mirror://gentoo/${PN}-all-0.1.tar.bz2 )"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="strip mirror"

IUSE="opengl dedicated"

DEPEND="app-arch/unzip"

RDEPEND="sys-libs/glibc
	opengl? (
		virtual/opengl
		amd64? (
			app-emulation/emul-linux-x86-xlibs
			|| (
				>=app-emulation/emul-linux-x86-xlibs-7.0
				|| ( >=media-video/nvidia-glx-1.0.6629-r3
					 x11-drivers/nvidia-drivers
					 x11-drivers/nvidia-legacy-drivers )
				>=x11-drivers/ati-drivers-8.8.25-r1 ) )
		x86? (
			|| (
				(
					x11-libs/libXext
					x11-libs/libX11 )
				virtual/x11 ) ) )
	amd64? (
			app-emulation/emul-linux-x86-compat )
	x86? ( =virtual/libstdc++-3.3 )
	dedicated? (
		app-misc/screen )"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	ewarn "The installed game takes about 1.6GB of space when installed and"
	ewarn "2.4GB of space in ${PORTAGE_TMPDIR} to build!"
}

src_unpack() {
	unpack_makeself ${DISTDIR}/${MY_P} || die "unpacking game"
	tar -zxf setupstuff.tar.gz || die
	if use dedicated; then
		unpack ${PN}-all-0.1.tar.bz2 || die
	fi
}

src_install() {
	einfo "This will take a while ... go get a pizza or something"

	dodir ${dir}

	tar -jxf armyops${PV}.tar.bz2 -C ${Ddir}/ || die "armyops untar failed"
	tar -jxf binaries.tar.bz2 -C ${Ddir}/ || die "binaries untar failed"

	dodoc README.linux
	insinto ${dir}
	doins ArmyOps.xpm README.linux ArmyOps${PV}_EULA.txt || die "doins failed"
	newicon ArmyOps.xpm armyops.xpm || die "doins failed"
	exeinto ${dir}
	doexe bin/armyops || die "doexe failed"
	fperms ug+x ${dir}/System/pb/pbweb.x86

	if use dedicated; then
		newinitd ${S}/armyops-ded.rc armyops-ded
		newconfd ${S}/armyops-ded.conf. armyops-ded
		games_make_wrapper armyops-ded ./server-bin ${dir}/System
	fi

	games_make_wrapper armyops ./armyops "${dir}" "${dir}"

	prepgamesdirs
	make_desktop_entry armyops "America's Army" armyops.xpm
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
