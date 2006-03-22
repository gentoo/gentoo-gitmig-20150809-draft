# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-inhell/doom3-inhell-1.1.ebuild,v 1.1 2006/03/22 03:10:07 wolf31o2 Exp $

inherit versionator games

MY_PV=$(replace_version_separator 1 '')

MOD="in_hell"
DESCRIPTION="Ultimate Doom-inspired levels for Doom 3"
HOMEPAGE="http://www.doomerland.de.vu/"
SRC_URI="mirror://filefront/Doom_III/Mods/Single_Player/in_hell_v${MY_PV}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror nostrip"

RDEPEND="games-fps/doom3"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

src_install() {
	mv In_Hell ${MOD}

	insinto "${GAMES_PREFIX_OPT}"/doom3/
	doins -r ${MOD} || die "doins failed"

	games_make_wrapper ${PN} "doom3 +set fs_game ${MOD}"
	make_desktop_entry ${PN} "Doom III - In Hell" doom3.png

	prepgamesdirs
}
