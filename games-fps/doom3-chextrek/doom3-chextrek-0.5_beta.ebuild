# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-chextrek/doom3-chextrek-0.5_beta.ebuild,v 1.2 2006/03/24 21:52:07 wolf31o2 Exp $

inherit versionator games

# Changes "0.5_beta" to "beta_0.5"
MY_PV=$(get_version_component_range 3-3)$(get_version_component_range 1-2)
MY_PV=${MY_PV/beta/beta_}
MY_P="chextrek${MY_PV}"

MOD="chextrek"
DESCRIPTION="Green slimeballs mod for kids"
HOMEPAGE="http://www.chextrek.xv15mods.com/"
SRC_URI="mirror://filefront/Doom_III/Supported_Mods/Beta_Releases/Chex_Trek_Beyond_the_Quest/${MY_P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror nostrip"

DEPEND="games-fps/doom3
	app-arch/unzip"

S=${WORKDIR}/${MY_P}
dir=${GAMES_PREFIX_OPT}/doom3

src_install() {
	insinto "${dir}"/${MOD}
	doins -r * || die "doins failed"

	games_make_wrapper ${PN} "doom3 +set fs_game ${MOD}"
	make_desktop_entry ${PN} "Doom III - Chex Trek" doom3.png

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	einfo "Press 'E' to open doors in the game."
	einfo "Press 'M' to toggle the map."
}
