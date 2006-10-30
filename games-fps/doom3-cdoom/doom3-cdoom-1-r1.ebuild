# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-cdoom/doom3-cdoom-1-r1.ebuild,v 1.1 2006/10/30 20:20:26 wolf31o2 Exp $

MOD_DESC="Doom 1 conversion for Doom 3"
MOD_NAME="Classic Doom"
MOD_DIR="cdoom"
MOD_ICON="doom3-cdoom.png"

inherit games games-mods

HOMEPAGE="http://cdoom.d3files.com/"
SRC_URI="mirror://filefront/Doom_III/Hosted_Mods/Final_Releases/classic_doom3_version${PV}.zip
	mirror://filefront/Doom_III/Hosted_Mods/Patches/cdoom3_v${PV}_update_patch.zip
	mirror://gentoo/${PN}.png"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"

src_unpack() {
	games-mods_src_unpack
	mkdir -p ${MOD_DIR}
	mv *.pk4 ${MOD_DIR}
	cp ${DISTDIR}/${PN}.png ${MOD_DIR}
}
