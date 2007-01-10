# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-unwheel/ut2004-unwheel-0_beta5.ebuild,v 1.2 2007/01/10 21:13:49 wolf31o2 Exp $

MOD_DESC="multiplayer driving mod focusing on fun driving"
MOD_NAME="Unwheel"
MOD_DIR="unwheel"

inherit versionator games games-mods

MY_PV=$(get_version_component_range 2-2)
MY_PV=${PV/0_beta/r}
MY_PN="unwheel"

HOMEPAGE="http://unwheel.beyondunreal.com/"
SRC_URI="mirror://beyondunreal/${MY_PN}/${MY_PN}_${MY_PV}.zip
	mirror://beyondunreal/${MY_PN}/packs/unwheel-r5_bonuspack-volume_1.zip"

LICENSE="as-is"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	mkdir -p ${MOD_DIR}
	unzip "${DISTDIR}"/${MY_PN}_${MY_PV}.zip -d ${MOD_DIR}
	unzip "${DISTDIR}"/unwheel-r5_bonuspack-volume_1.zip -d ${MOD_DIR}
}
