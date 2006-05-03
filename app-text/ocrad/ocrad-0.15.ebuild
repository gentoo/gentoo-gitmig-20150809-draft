# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ocrad/ocrad-0.15.ebuild,v 1.1 2006/05/03 20:04:57 ehmsen Exp $

inherit toolchain-funcs eutils

IUSE=""

DESCRIPTION="GNU Ocrad is an OCR (Optical Character Recognition) program"

SRC_URI="http://savannah.nongnu.org/download/ocrad/${P}.tar.bz2"
HOMEPAGE="http://www.gnu.org/software/ocrad/ocrad.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"

DEPEND="virtual/libc"

src_compile() {
	# econf doesn't work (unrecognized option --host)
	./configure --prefix=/usr || die
	emake CXX="$(tc-getCXX)" CXXFLAGS="${CXXFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die

	doman doc/ocrad.1
	dodoc NEWS TODO README
	insinto /usr/share/doc/${PF}
	doins -r examples
}
