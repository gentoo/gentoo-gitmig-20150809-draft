# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/splat/splat-1.2.2-r1.ebuild,v 1.2 2009/09/23 20:00:57 patrick Exp $

inherit toolchain-funcs eutils

DESCRIPTION="SPLAT! is an RF Signal Propagation, Loss, And Terrain analysis tool for the spectrum between 20 MHz and 20 GHz."
HOMEPAGE="http://www.qsl.net/kd2bd/splat.html"
SRC_URI="http://www.qsl.net/kd2bd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc linguas_es"

DEPEND="sys-libs/zlib
	app-arch/bzip2"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	local CC=$(tc-getCC) CXX=$(tc-getCXX)

	${CXX} -Wall ${CXXFLAGS} ${LDFLAGS} itm.cpp splat.cpp -o splat -lm -lbz2 || die

	cd utils
	${CC} -Wall ${CFLAGS} ${LDFLAGS} citydecoder.c -o citydecoder
	${CC} -Wall ${CFLAGS} ${LDFLAGS} usgs2sdf.c    -o usgs2sdf
	${CC} -Wall ${CFLAGS} ${LDFLAGS} srtm2sdf.c    -o srtm2sdf   -lbz2
	#${CC} -Wall ${CFLAGS} ${LDFLAGS} fontdata.c    -o fontdata   -lz
	${CC} -Wall ${CFLAGS} ${LDFLAGS} bearing.c     -o bearing    -lm
}

src_install() {
	local SPLAT_LANG="english"
	use linguas_es && SPLAT_LANG="spanish"
	# splat binary
	dobin splat || die

	# utilities
	dobin utils/{citydecoder,usgs2sdf,srtm2sdf,postdownload,bearing} || die
	newman docs/${SPLAT_LANG}/man/splat.man splat.1 || die

	dodoc CHANGES README utils/fips.txt || die
	newdoc utils/README README.UTILS || die

	if use doc; then
		dodoc docs/${SPLAT_LANG}/{pdf/splat.pdf,postscript/splat.ps} || die
	fi
	#sample data
	docinto sample_data
	dodoc sample_data/* || die

}
