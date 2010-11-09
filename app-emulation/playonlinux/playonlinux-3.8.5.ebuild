# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/playonlinux/playonlinux-3.8.5.ebuild,v 1.1 2010/11/09 00:32:18 volkmar Exp $

EAPI="2"

inherit eutils python games

MY_PN="PlayOnLinux"

DESCRIPTION="Set of scripts to easily install and use Windows(tm) games and softwares"
HOMEPAGE="http://playonlinux.com/"
SRC_URI="http://www.playonlinux.com/script_files/${MY_PN}/${PV}/${MY_PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-emulation/wine
	app-arch/cabextract
	app-arch/unzip
	dev-python/wxpython:2.8
	|| ( media-gfx/imagemagick media-gfx/graphicsmagick[imagemagick] )
	net-misc/wget
	x11-apps/mesa-progs
	x11-terms/xterm"

S=${WORKDIR}/${PN}

# TODO:
# Having a real install script and let playonlinux use standard filesystem
# 	architecture to prevent having everything installed into GAMES_DATADIR
# It will let using LANGUAGES easily
# How to deal with Microsoft Fonts installation asked every time ?
# How to deal with wine version installed ? (have a better mgmt of system one)
# Look at debian pkg: http://packages.debian.org/sid/playonlinux

src_prepare() {
	sed -i -e "s/\(Categories=\).*/\1Game;Emulator;/" etc/PlayOnLinux.desktop \
		|| die "sed failed"
}

src_install() {
	# all things without exec permissions
	insinto "${GAMES_DATADIR}/${PN}"
	doins -r themes lang lib etc plugins || die "doins failed"

	# bash/ install
	exeinto "${GAMES_DATADIR}/${PN}/bash"
	doexe bash/* || die "doexe failed"
	exeinto "${GAMES_DATADIR}/${PN}/bash/terminals"
	doexe bash/terminals/* || die "doexe failed"
	exeinto "${GAMES_DATADIR}/${PN}/bash/expert"
	doexe bash/expert/* || die "doexe failed"
	exeinto "${GAMES_DATADIR}/${PN}/bash/daemon"
	doexe bash/daemon/* || die "doexe failed"

	# python/ install
	exeinto "${GAMES_DATADIR}/${PN}/python"
	doexe python/* || die "doexe failed"
	# sub dir without exec permissions
	insinto "${GAMES_DATADIR}/${PN}/python"
	doins -r python/lib || die "doins failed"

	# main executable files
	exeinto "${GAMES_DATADIR}/${PN}"
	doexe ${PN}{,-pkg,-daemon,-cmd,-shell} || die "doexe failed"

	# making a script to run playonlinux from ${GAMES_BINDIR}
	echo "#!/bin/bash" > ${PN}_launcher
	echo "cd \"${GAMES_DATADIR}/${PN}\" && ./${PN} \$*" >> ${PN}_launcher
	newgamesbin playonlinux_launcher playonlinux || die "newgamesbin failed"

	# making a script to run playonlinux-cmd from ${GAMES_BINDIR}
	echo "#!/bin/bash" > ${PN}_cmd_launcher
	echo "cd \"${GAMES_DATADIR}/${PN}\" && ./${PN}-cmd \$*" >> ${PN}_cmd_launcher
	newgamesbin playonlinux_cmd_launcher playonlinux-cmd || die "newgamesbin failed"

	dodoc CHANGELOG || die "dodoc failed"

	doicon etc/${PN}.png || die "doicon failed"
	domenu etc/${MY_PN}.desktop || die "domenu failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	python_mod_optimize "${GAMES_DATADIR}/${PN}"
}

pkg_postrm() {
	python_mod_cleanup "${GAMES_DATADIR}/${PN}"

	ewarn "Installed softwares and games with playonlinux have not been removed."
	ewarn "To remove them, you can re-install playonlinux and remove them using it"
	ewarn "or do it manually by removing .PlayOnLinux/ in your home directory."
}
