# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-brainworks/quake3-brainworks-0.91-r1.ebuild,v 1.2 2009/10/01 21:20:00 nyhm Exp $

MOD_DESC="Enhanced AI for the Quake III Bots"
MOD_NAME="Brainworks"
MOD_DIR=i"ainworks" # ?

inherit games games-mods

HOMEPAGE="http://www.planetquake.com/artofwar"
SRC_URI="http://droopy.laggyservers.com/q3a/brainworks/brainworks-0-91.zip"

LICENSE="freedist"
KEYWORDS="-* ~amd64 ~ppc ~x86"
IUSE="dedicated opengl"
RESTRICT="strip mirror fetch"

pkg_nofetch() {
	einfo "Go to http://artofwar.planetquake.gamespy.com/downloads.html and"
	einfo "download ${A}, then put it into ${DISTDIR}."
}
