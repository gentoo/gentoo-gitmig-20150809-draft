# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-matrix/quake3-matrix-2.4_beta.ebuild,v 1.1 2004/12/27 04:20:40 vapier Exp $

MOD_DESC="Matrix"
MOD_NAME=matrix
inherit games games-q3mod

HOMEPAGE="http://www.public.iastate.edu/~areinot/matrix/matrix.html"
SRC_URI="matrix24.zip"

LICENSE="Q3AEULA"
RESTRICT="fetch"

pkg_nofetch() {
	einfo "Download the following files from FilePlanet and put them in"
	einfo "${DISTDIR}"
	einfo
	einfo "http://www.fileplanet.com/download.aspx?f=110838"
}
