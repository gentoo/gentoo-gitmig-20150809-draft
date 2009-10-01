# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-mitm/doom3-mitm-20060328.ebuild,v 1.6 2009/10/01 20:56:19 nyhm Exp $

EAPI=2
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
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

RDEPEND="games-fps/doom3-roe
	games-fps/doom3[roe]"

S=${WORKDIR}

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
	make_desktop_entry ${PN} "Doom III - Make it to Morning (1)" doom3
	local n
	for n in {2,3} ; do
		games_make_wrapper ${PN}${n} \
			"doom3 +set fs_game ${MOD_DIR} +set fs_game_base d3xp +map mitm${n}"
		make_desktop_entry ${PN}${n} \
			"Doom III - Make it to Morning (${n})" doom3
	done
}
