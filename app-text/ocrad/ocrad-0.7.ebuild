# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ocrad/ocrad-0.7.ebuild,v 1.2 2004/03/18 15:48:08 dholm Exp $

IUSE=""

DESCRIPTION="GNU Ocrad is an OCR (Optical Character Recognition) program"

SRC_URI="http://savannah.nongnu.org/download/ocrad/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/ocrad/ocrad.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr || die
	emake || die
}

src_install() {
	dobin ocrad
	doinfo doc/ocrad.info
	doman doc/ocrad.1
}
