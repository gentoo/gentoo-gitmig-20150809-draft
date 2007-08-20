# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/americas-army/americas-army-250.ebuild,v 1.17 2007/08/20 22:34:00 mr_bones_ Exp $

inherit eutils games

DED_PV="0.2"
DED_FILE="${PN}-all-${DED_PV}.tar.bz2"
MY_P="armyops${PV}-linux.run"

DESCRIPTION="military simulations by the U.S. Army to provide civilians with insights on soldiering"
HOMEPAGE="http://www.americasarmy.com/"
SRC_URI="mirror://3dgamers/${PN/-/}/${MY_P}
	dedicated? (
		http://dev.gentoo.org/~wolf31o2/sources/dump/${DED_FILE}
		mirror://gentoo/${DED_FILE} )"

LICENSE="Army-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="mirror strip"
IUSE="dedicated opengl"

UIDEPEND="virtual/opengl
		amd64? (
			app-emulation/emul-linux-x86-xlibs
			|| (
				>=app-emulation/emul-linux-x86-xlibs-7.0
				x11-drivers/nvidia-drivers
				>=x11-drivers/ati-drivers-8.8.25-r1 ) )
		x86? (
			x11-libs/libXext
			x11-libs/libX11 )"
RDEPEND="sys-libs/glibc
	opengl? ( ${UIDEPEND} )
	!opengl? ( !dedicated? ( ${UIDEPEND} ) )
	amd64? ( app-emulation/emul-linux-x86-compat )
	x86? ( =virtual/libstdc++-3.3 )"

S=${WORKDIR}

pkg_setup() {
	games_pkg_setup
	einfo "The installed game takes about 1.6GB of space when installed and"
	einfo "2.4GB of space in ${PORTAGE_TMPDIR} to build!"
	echo
}

src_unpack() {
	unpack_makeself "${DISTDIR}/${MY_P}" || die "unpacking game"
	unpack ./setupstuff.tar.gz
	if use dedicated ; then
		unpack "${DED_FILE}"
	fi
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}
	local Ddir=${D}/${dir}

	einfo "This will take a while... go get a pizza or something."

	dodir "${dir}"
	tar -jxf armyops${PV}.tar.bz2 -C "${Ddir}"/ || die "armyops untar failed"
	tar -jxf binaries.tar.bz2 -C "${Ddir}"/ || die "binaries untar failed"

	dodoc README.linux
	insinto "${dir}"
	doins ArmyOps.xpm README.linux ArmyOps${PV}_EULA.txt || die "doins failed"
	newicon ArmyOps.xpm armyops.xpm || die "newicon failed"
	exeinto "${dir}"
	doexe bin/armyops || die "doexe failed"
	fperms ug+x "${dir}"/System/pb/pbweb.x86

	if use dedicated ; then
		newinitd "${S}"/armyops-ded.rc armyops-ded || die
		newconfd "${S}"/armyops-ded.conf.d armyops-ded || die
		games_make_wrapper armyops-ded ./server-bin "${dir}"/System
	fi

	if use opengl || ! use dedicated ; then
		games_make_wrapper armyops ./armyops "${dir}" "${dir}"
		make_desktop_entry armyops "America's Army" armyops.xpm
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if use dedicated ; then
		elog "To start a dedicated server, run:"
		elog "   /etc/init.d/armyops-ded start"
		echo
	fi
	if use opengl || ! use dedicated ; then
		elog "To play the game, run:  armyops"
		echo
	fi
}
