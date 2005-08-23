# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/dzip/dzip-2.9-r1.ebuild,v 1.2 2005/08/23 20:37:18 wolf31o2 Exp $

inherit eutils games

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/dzip-2.9-scrub-names.patch #93079
}

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
