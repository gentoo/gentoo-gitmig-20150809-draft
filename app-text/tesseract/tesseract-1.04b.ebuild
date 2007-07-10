# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tesseract/tesseract-1.04b.ebuild,v 1.1 2007/07/10 18:28:56 chutzpah Exp $

inherit eutils multilib

DESCRIPTION="A commercial quality OCR engine developed at HP in the 80's and early 90's."
HOMEPAGE="http://code.google.com/p/tesseract-ocr/"
SRC_URI="http://tesseract-ocr.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="media-libs/tiff"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P%b}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-globals.patch
	sed -i -e "s:/usr/bin/X11/xterm:/usr/bin/xterm:" ccutil/debugwin.cpp
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc README AUTHORS phototest.tif
}
