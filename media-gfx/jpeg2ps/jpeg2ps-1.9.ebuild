# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jpeg2ps/jpeg2ps-1.9.ebuild,v 1.4 2004/11/27 06:47:52 pclouds Exp $

DESCRIPTION="Converts JPEG images to Postscript using a wrapper"
HOMEPAGE="http://www.pdflib.com/products/more/jpeg2ps.html"
SRC_URI="http://www.pdflib.com/products/more/jpeg2ps/${P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

DEPEND="sys-apps/sed"
RDEPEND=""

src_compile() {
	# remove the -DA4 paper size default and use our ${CFLAGS}
	sed -i \
		-e "s/CFLAGS=-c -DA4$/CFLAGS=-c ${CFLAGS}/" \
		Makefile || \
			die "sed Makefile failed"
	emake || die "emake failed"
}

src_install() {
	# The Makefile is hard-coded to install to /usr/local/ so we
	# simply copy the files manually
	dobin jpeg2ps || die "dobin failed"
	doman jpeg2ps.1 || die "doman failed"
	dodoc jpeg2ps.txt || die "dodoc failed"
}

pkg_postinst() {
	einfo
	einfo "By default, this installation of jpeg2ps will generate"
	einfo "letter size output.  You can force A4 output with"
	einfo "    jpeg2ps -p a4 file.jpg > file.ps"
	einfo
}

