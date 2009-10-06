# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-matrix/quake3-matrix-2.4_beta-r1.ebuild,v 1.4 2009/10/06 23:47:25 nyhm Exp $

EAPI=2

MOD_DESC="Matrix conversion mod"
MOD_NAME="matrix"
MOD_DIR="matrix"

inherit games games-mods

HOMEPAGE="http://www.moddb.com/mods/matrix-quake-3"
SRC_URI="http://www.mirrorservice.org/sites/quakeunity.com/modifications/matrix24.zip"

LICENSE="freedist"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"

src_unpack() {
	mkdir ${MOD_DIR}
	cd ${MOD_DIR}
	unpack ${A}
}
