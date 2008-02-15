# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-mitm/doom3-mitm-20060328.ebuild,v 1.3 2008/02/15 00:40:07 wolf31o2 Exp $

MOD_DESC="single-player map trilogy"
MOD_NAME="Make it to Morning"
MOD_DIR="mitm"

inherit eutils versionator games games-mods

# End up with MY_PV=03282k6
DATE=$(get_version_component_range 1-1)
MY_PV=${DATE:4:4}-${DATE:0:4}
MY_PV=${MY_PV/-2006/2k6}

HOMEPAGE="http://www.makeittomorning.co.uk"
SRC_URI="mirror://filefront/Doom_III/Resurrection_of_Evil/Maps/Single_Player/make_it_to_morning_${MY_PV}.zip"

LICENSE="as-is"

RDEPEND="games-fps/doom3-roe"

S=${WORKDIR}

pkg_setup() {
	games-mods_pkg_setup
	if ! built_with_use games-fps/doom3 roe
	then
		eerror "You need to install games-fps/doom3 with the roe USE flag."
		die "Needs USE=roe games-fps/doom3"
	fi
}

src_unpack() {
	games-mods_src_unpack
	mkdir -p mitm
	mv "MITM Readme.txt" README.MITM
	mv mitm.pk4 mitm
}

src_install() {
	games-mods_src_install
	games_make_wrapper ${PN} \
		"doom3 +set fs_game ${MOD_DIR} +set fs_game_base d3xp +map mitm"
	make_desktop_entry ${PN} "Doom III - Make it to Morning (1)" doom3.png
	local n
	for n in {2,3} ; do
		games_make_wrapper ${PN}${n} \
			"doom3 +set fs_game ${MOD_DIR} +set fs_game_base d3xp +map mitm${n}"
		make_desktop_entry ${PN}${n} \
			"Doom III - Make it to Morning (${n})" doom3.png
	done
}
