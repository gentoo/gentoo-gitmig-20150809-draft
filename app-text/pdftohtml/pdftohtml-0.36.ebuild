# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdftohtml/pdftohtml-0.36.ebuild,v 1.8 2004/08/31 16:16:40 slarti Exp $

DESCRIPTION="pdftohtml is a utility which converts PDF files into HTML and XML formats"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 sparc ~ppc ~amd64"
IUSE=""
DEPEND="virtual/libc sys-devel/gcc"
RDEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	dobin pdftohtml
	dodoc AUTHORS BUGS CHANGES COPYING README pdf2xml.dtd
}
