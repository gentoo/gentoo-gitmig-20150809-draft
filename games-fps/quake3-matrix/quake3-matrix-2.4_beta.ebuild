# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-matrix/quake3-matrix-2.4_beta.ebuild,v 1.2 2006/06/27 19:27:41 wolf31o2 Exp $

MOD_DESC="Matrix"
MOD_NAME=matrix
inherit games games-q3mod

# All other HOMEPAGE have disappeared
HOMEPAGE="http://mods.moddb.com/3388/matrix-quake-3/"
SRC_URI="matrix24.zip"

LICENSE="Q3AEULA"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Download the following files from FilePlanet and put them in"
	einfo "${DISTDIR}"
	einfo
	einfo "http://www.fileplanet.com/download.aspx?f=110838"
}
