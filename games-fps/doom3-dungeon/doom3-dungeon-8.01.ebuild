# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-dungeon/doom3-dungeon-8.01.ebuild,v 1.1 2006/11/01 15:29:52 wolf31o2 Exp $

MOD_DESC="rogue-like 3D mod"
MOD_NAME="Dungeon"
MOD_DIR="dungeon"

inherit versionator eutils games games-mods

MY_PV=$(delete_all_version_separators)

HOMEPAGE="http://dungeondoom.d3files.com/"
SRC_URI="mirror://filefront/Doom_III/Hosted_Mods/Final_Releases/DungeonDOOM/${MOD_DIR}doom${MY_PV}xplinux.zip"

# See bottom of /opt/doom3/dungeondoom/readme.txt
LICENSE="as-is"

KEYWORDS="~amd64 ~x86"

RDEPEND="games-fps/doom3-roe
	games-fps/doom3"

S=${WORKDIR}

pkg_setup() {
	if ! built_with_use games-fps/doom3 roe
	then
		eerror "You need to install games-fps/doom3 with the roe USE flag."
		die "Needs USE=roe games-fps/doom3"
	fi
}

src_unpack() {
	games-mods_src_unpack
	# Standardize directory name.
	local dir=$(find . -maxdepth 1 -name "dungeon*" -type d)
	mv "${dir}" "${MOD_DIR}" || die "mv ${dir} failed"
}
