# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-brainworks/quake3-brainworks-0.91-r1.ebuild,v 1.1 2006/10/23 21:24:55 wolf31o2 Exp $

MOD_DESC="Enhanced AI for the Quake III Bots"
MOD_NAME="Brainworks"
MOD_DIR=i"ainworks"

inherit games games-mods

HOMEPAGE="http://www.planetquake.com/artofwar"
SRC_URI="http://droopy.laggyservers.com/q3a/brainworks/brainworks-0-91.zip"

LICENSE="freedist"
RESTRICT="strip mirror fetch"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"

pkg_nofetch() {
	einfo "Go to http://artofwar.planetquake.gamespy.com/downloads.html and"
	einfo "download ${A}, then put it into ${DISTDIR}."
}
