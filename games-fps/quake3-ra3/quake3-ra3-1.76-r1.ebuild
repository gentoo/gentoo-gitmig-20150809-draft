# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-ra3/quake3-ra3-1.76-r1.ebuild,v 1.1 2006/10/24 21:18:21 wolf31o2 Exp $

MOD_DESC="a rocket dueling mod"
MOD_NAME="Rocket Arena 3"
MOD_DIR="arena"
MOD_BINS="ra3"

inherit games games-mods

SRC_URI="ra3176.zip"
HOMEPAGE="http://www.planetquake.com/servers/arena/"

LICENSE="freedist"
RESTRICT="mirror strip fetch"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"

pkg_nofetch() {
	einfo "Download the following files from FilePlanet and put them in"
	einfo "${DISTDIR}"
	echo
	einfo "http://www.fileplanet.com/hosteddl.aspx?servers%2farena%2fra3176.zip"
}
