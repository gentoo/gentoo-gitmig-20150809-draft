# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/splat/splat-1.1.0.ebuild,v 1.1 2005/02/26 21:19:26 xmerlin Exp $

inherit eutils

DESCRIPTION="SPLAT! is an RF Signal Propagation, Loss, And Terrain analysis tool for the spectrum between 20 MHz and 20 GHz."
HOMEPAGE="http://www.qsl.net/kd2bd/splat.html"
SRC_URI="ftp://ftp.ibiblio.org/pub/linux/apps/ham/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib
	doc? (
		app-text/ghostscript
		sys-apps/groff
		)
	"

src_compile() {
	g++ -Wall ${CXXFLAGS} -s -lm -lbz2 itm.cpp splat.cpp -o splat || die

	cd utils
	cc -Wall ${CFLAGS} -s citydecoder.c -o citydecoder
	cc -Wall ${CFLAGS} -s usgs2sdf.c -o usgs2sdf
	cc -Wall ${CFLAGS} -s -lz fontdata.c -o fontdata

	cd ../docs/man
	groff -e -T ascii -man splat.man > splat.1 2>/dev/null

	if use doc; then
		groff -man -Tascii -P'-bcou' -man splat.man 1> splat.txt 2>/dev/null
		groff -e -T ps -man splat.man 1> splat.ps 2>/dev/null
		ps2pdf splat.ps splat.pdf 2>/dev/null
	fi
}

src_install() {
	# splat binary
	dobin splat || die

	# utilities
	dobin utils/{citydecoder,usgs2sdf,postdownload} || die
	doman docs/man/${PN}.1 || die

	dodoc CHANGES README utils/fips.txt sample.lrp
	if use doc; then
		dodoc docs/man/${PN}.pdf docs/man/${PN}.txt || die
	fi
}
