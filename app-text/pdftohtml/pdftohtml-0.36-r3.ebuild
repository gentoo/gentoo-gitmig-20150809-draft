# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdftohtml/pdftohtml-0.36-r3.ebuild,v 1.9 2006/01/08 22:01:29 nattfodd Exp $

inherit eutils

DESCRIPTION="pdftohtml is a utility which converts PDF files into HTML and XML formats"
HOMEPAGE="http://pdftohtml.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos ppc64 sparc x86"
IUSE=""
DEPEND="virtual/libc
		sys-devel/gcc
		!app-text/poppler"
RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-d ${S}/xpdf -p0" epatch ${FILESDIR}/xpdf-CESA-2004-007-xpdf2-newer.diff
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xpdf-goo-sizet.patch
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xpdf2-underflow.patch
	EPATCH_OPTS="-d ${S}/xpdf -p0" epatch ${FILESDIR}/pdftohtml-xpdf-3.00pl2-CAN-2004-1125.patch
	EPATCH_OPTS="-d ${S}/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl3-keylength.patch

	# fix location of xpdfrc
	sed -i "s:/usr/local/etc/xpdfrc:/etc/xpdfrc:" aconf.h
}

src_compile() {
	emake || die
}

src_install() {
	dobin pdftohtml
	dodoc AUTHORS BUGS CHANGES COPYING README pdf2xml.dtd
}
