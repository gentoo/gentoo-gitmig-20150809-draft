# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/doom3-lms/doom3-lms-3.ebuild,v 1.1 2006/03/22 03:01:23 wolf31o2 Exp $

inherit games

MOD="lms${PV}"
DESCRIPTION="Add co-op support and/or play against swarms of unending monsters"
HOMEPAGE="http://lms.d3files.com/"
SRC_URI="mirror://filefront/Doom_III/Hosted_Mods/Final_Releases/lms_${PV}_multiplatform.zip"

# See /opt/doom3/lms3/docs/license.txt
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror nostrip"

DEPEND="games-fps/doom3
	app-arch/unzip"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_PREFIX_OPT}"/doom3
	doins -r ${MOD} || die "doins failed"

	games_make_wrapper ${PN} "doom3 +set fs_game ${MOD}"
	make_desktop_entry ${PN} "Doom III - Last Man Standing" doom3.png

	prepgamesdirs
}
