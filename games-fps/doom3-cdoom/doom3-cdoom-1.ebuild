# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-cdoom/doom3-cdoom-1.ebuild,v 1.1 2006/03/22 03:11:01 wolf31o2 Exp $

inherit games

MOD="cdoom"
DESCRIPTION="Doom 1 conversion for Doom 3"
HOMEPAGE="http://cdoom.d3files.com/"
SRC_URI="mirror://filefront/Doom_III/Hosted_Mods/Final_Releases/classic_doom3_version${PV}.zip
	mirror://filefront/Doom_III/Hosted_Mods/Patches/cdoom3_v${PV}_update_patch.zip
	mirror://gentoo/${PN}.png
	http://dev.gentoo.org/~wolf31o2/sources/dump/${PN}.png"

# See /opt/doom3/cdoom/docs/license.txt
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
	mv *.pk4 ${MOD}/

	insinto "${GAMES_PREFIX_OPT}"/doom3
	doins -r ${MOD} || die "doins failed"

	games_make_wrapper ${PN} "doom3 +set fs_game ${MOD}"
	doicon ${DISTDIR}/${PN}.png
	make_desktop_entry ${PN} "Doom III - Classic Doom" ${PN}.png

	prepgamesdirs
}
