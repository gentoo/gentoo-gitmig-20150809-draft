# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-matrix/quake3-matrix-2.4_beta-r1.ebuild,v 1.2 2008/02/15 01:11:05 wolf31o2 Exp $

MOD_DESC="Matrix conversion mod"
MOD_NAME="matrix"
MOD_DIR="matrix"

inherit games games-mods

# All other HOMEPAGE have disappeared
HOMEPAGE="http://mods.moddb.com/3388/matrix-quake-3/"
SRC_URI="matrix24.zip"

LICENSE="freedist"
RESTRICT="strip fetch"

KEYWORDS="-* ~amd64 ~ppc ~x86"

RDEPEND="ppc? ( games-fps/${GAME} )
	!ppc? (
		|| (
			games-fps/${GAME}
			games-fps/${GAME}-bin ) )"

pkg_nofetch() {
	einfo "Download the following files from FilePlanet and put them in"
	einfo "${DISTDIR}"
	einfo
	einfo "http://www.fileplanet.com/download.aspx?f=110838"
}

src_unpack() {
	games-mods_src_unpack
	mkdir -p "${S}"/matrix
	mv *.pk3 *.txt matrix
}
