# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/splat/splat-1.1.0.ebuild,v 1.2 2005/02/28 01:18:14 xmerlin Exp $

inherit toolchain-funcs

DESCRIPTION="SPLAT! is an RF Signal Propagation, Loss, And Terrain analysis tool for the spectrum between 20 MHz and 20 GHz."
HOMEPAGE="http://www.qsl.net/kd2bd/splat.html"
SRC_URI="ftp://ftp.ibiblio.org/pub/linux/apps/ham/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib
	app-arch/bzip2
	"

RDEPEND=""

src_compile() {
	local CC=$(tc-getCC) CXX=$(tc-getCXX)
	local STRIP=""

	if ! has nostrip ${FEATURES} ; then
		local STRIP="-s"
	fi

	${CXX} -Wall ${CXXFLAGS} -lm -lbz2 itm.cpp splat.cpp -o splat || die

	cd utils
	${CC} -Wall ${CFLAGS} citydecoder.c -o citydecoder
	${CC} -Wall ${CFLAGS} usgs2sdf.c -o usgs2sdf
	${CC} -Wall ${CFLAGS} -lz fontdata.c -o fontdata

}

src_install() {
	# splat binary
	dobin splat || die

	# utilities
	dobin utils/{citydecoder,usgs2sdf,postdownload} || die
	newman docs/man/splat.man splat.1

	dodoc CHANGES README utils/fips.txt sample.lrp
	newdoc utils/README README.UTILS
}
