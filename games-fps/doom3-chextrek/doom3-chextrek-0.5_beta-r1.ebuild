# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-chextrek/doom3-chextrek-0.5_beta-r1.ebuild,v 1.2 2007/03/12 14:29:13 genone Exp $

MOD_DESC="Green slimeballs mod for kids"
MOD_NAME="Chex Trek: Beyond the Quest"
MOD_DIR="chextrek"

inherit eutils versionator games games-mods

# Changes "0.5_beta" to "beta_0.5"
MY_PV=$(get_version_component_range 3-3)$(get_version_component_range 1-2)
MY_PV=${MY_PV/beta/beta_}
MY_P="chextrek${MY_PV}"

HOMEPAGE="http://www.chextrek.xv15mods.com/"
SRC_URI="mirror://filefront/Doom_III/Supported_Mods/Beta_Releases/Chex_Trek_Beyond_the_Quest/${MY_P}.zip"

LICENSE="as-is"

KEYWORDS="~amd64 ~x86"

RDEPEND="games-fps/doom3"

S=${WORKDIR}

src_unpack() {
	games-mods_src_unpack
	mkdir -p ${MOD_DIR}
	mv ${MY_P}/*.{txt,pk4} ${MOD_DIR} || die
}

pkg_postinst() {
	games-mods_pkg_postinst
	elog "Press 'E' to open doors in the game."
	elog "Press 'M' to toggle the map."
	echo
}
