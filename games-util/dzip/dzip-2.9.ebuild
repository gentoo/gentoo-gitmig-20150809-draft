# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/dzip/dzip-2.9.ebuild,v 1.1 2004/02/16 10:39:14 mr_bones_ Exp $

inherit games

S="${WORKDIR}"
DESCRIPTION="compressor/uncompressor for demo recordings from id's Quake"
HOMEPAGE="http://www.planetquake.com/sda/dzip/"
SRC_URI="http://mysite.verizon.net/vze4pmvd/dz${PV/./}src.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="virtual/glibc"

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
