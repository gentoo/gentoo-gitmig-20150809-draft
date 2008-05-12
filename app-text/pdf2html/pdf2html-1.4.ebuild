# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdf2html/pdf2html-1.4.ebuild,v 1.17 2008/05/12 15:57:26 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Converts pdf files to html files"
SRC_URI="ftp://atrey.karlin.mff.cuni.cz/pub/local/clock/pdf2html/${P}.tgz"
HOMEPAGE="http://atrey.karlin.mff.cuni.cz/~clock/twibright/pdf2html/"
LICENSE="GPL-2"

KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE=""
SLOT="0"

DEPEND=">=media-libs/libpng-1.2.5"
RDEPEND="${DEPEND}
	virtual/ghostscript
	>=media-gfx/imagemagick-5.4.9"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	tc-export CC
	# Rewrite the Makefile as that's simpler
	echo "LDLIBS=-lpng" > Makefile
	echo "all: pbm2png" >> Makefile
	emake || die "failed to compile pbm2png"
	echo "pbm2eps9: pbm2eps9.o printer.o" > Makefile
	emake pbm2eps9 || die "failed to compile pbm2eps9"

	echo "cp /usr/share/${P}/*.png ." >> pdf2html
}

src_install() {
	dobin pbm2png pbm2eps9 pdf2html ps2eps9  || die "install failed"

	insinto /usr/share/${P}
	doins *.png *.html

	dodoc CHANGELOG README VERSION || die "install failed"
}
