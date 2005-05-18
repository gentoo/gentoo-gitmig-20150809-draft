# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/dzip/dzip-2.9.ebuild,v 1.5 2005/05/18 16:17:06 mr_bones_ Exp $

inherit games

DESCRIPTION="compressor/uncompressor for demo recordings from id's Quake"
HOMEPAGE="http://speeddemosarchive.com/dzip/"
SRC_URI="http://speeddemosarchive.com/dzip/dz${PV/./}src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S=${WORKDIR}

src_compile() {
	emake CFLAGS="${CFLAGS}" -f Makefile.linux || die "emake failed"
}

src_install () {
	dogamesbin dzip || die "dogamesbin failed"
	dodoc Readme || die "dodoc failed"
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	echo
	einfo "Demo files can be found at http://planetquake.com/sda/"
	einfo "and http://planetquake.com/qdq/"
	echo
}
