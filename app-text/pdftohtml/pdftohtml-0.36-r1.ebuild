# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdftohtml/pdftohtml-0.36-r1.ebuild,v 1.1 2004/11/22 10:49:24 robbat2 Exp $

inherit eutils

DESCRIPTION="pdftohtml is a utility which converts PDF files into HTML and XML formats"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64 ppc64"
IUSE=""
DEPEND="virtual/libc sys-devel/gcc"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}/xpdf -p0" epatch ${FILESDIR}/xpdf-CESA-2004-007-xpdf2-newer.diff
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xpdf-goo-sizet.patch
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xpdf2-underflow.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin pdftohtml
	dodoc AUTHORS BUGS CHANGES COPYING README pdf2xml.dtd
}
