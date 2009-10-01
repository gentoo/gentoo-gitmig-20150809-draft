# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-dungeon/doom3-dungeon-8.01.ebuild,v 1.7 2009/10/01 20:52:29 nyhm Exp $

EAPI=2
MOD_DESC="rogue-like 3D mod"
MOD_NAME="Dungeon"
MOD_DIR="dungeon"

inherit versionator eutils games games-mods

MY_PV=$(delete_all_version_separators)

HOMEPAGE="http://dungeondoom.d3files.com/"
SRC_URI="mirror://filefront/Doom_III/Hosted_Mods/Final_Releases/DungeonDOOM/${MOD_DIR}doom${MY_PV}xplinux.zip"

LICENSE="as-is"
KEYWORDS="amd64 x86"
IUSE="dedicated opengl"

RDEPEND="games-fps/doom3-roe
	games-fps/doom3[roe]"

S=${WORKDIR}

src_prepare() {
	# Standardize directory name.
	local dir=$(find . -maxdepth 1 -name "dungeon*" -type d)
	mv "${dir}" "${MOD_DIR}" || die "mv ${dir} failed"
}

src_install() {
	games-mods_src_install
	games_make_wrapper ${PN} \
		"doom3 +set fs_game ${MOD_DIR} +set fs_game_base d3xp"
}
