# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ocrad/ocrad-0.9.ebuild,v 1.1 2004/11/04 16:07:46 usata Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="GNU Ocrad is an OCR (Optical Character Recognition) program"

SRC_URI="http://savannah.nongnu.org/download/ocrad/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/ocrad/ocrad.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/libc"

src_compile() {
	# econf doesn't work (unrecognized option --host)
	./configure --prefix=/usr || die
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	dobin ocrad
	doinfo doc/ocrad.info
	doman doc/ocrad.1
}
