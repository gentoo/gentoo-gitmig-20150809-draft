# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory-truecombat/enemy-territory-truecombat-0.49b.ebuild,v 1.2 2007/08/21 00:54:24 wolf31o2 Exp $

MY_PV=${PV/./}

MOD_DESC="a team-based realism modification"
MOD_NAME="True Combat"
MOD_ICON="tce_icon_pc.ico"
MOD_DIR="tcetest"
GAME="enemy-territory"

inherit games games-mods

HOMEPAGE="http://truecombat.com/"
SRC_URI="http://dragons-perch.net/tce/tcetest049.zip
	http://freeserver.name/files/installer/linux/tcetest049.zip
	http://mirror.rosvosektori.net/tcetest049.zip
	http://dragons-perch.net/tce/tce${MY_PV}_all_os_fixed.zip"

LICENSE="as-is"

KEYWORDS="-* ~amd64 ~x86"

RDEPEND="games-fps/${GAME}
	x86? ( =virtual/libstdc++-3.3 )
	amd64? ( app-emulation/emul-linux-x86-compat )"

src_unpack() {
	games-mods_src_unpack
	mv *.{so,dat,pk3,dll} "${MOD_DIR}" || die
}
