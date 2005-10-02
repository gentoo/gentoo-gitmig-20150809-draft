# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/wcstools/wcstools-3.6.2.ebuild,v 1.1 2005/10/02 15:22:55 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="Astronomy Library to handle World Coordinate System for FITS images"
HOMEPAGE="http://tdc-www.harvard.edu/software/wcstools"
SRC_URI="http://tdc-www.harvard.edu/software/${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die
}

src_install () {
	dobin wcstools bin/* || die
	dolib.a libwcs/*.a || die
	dodoc Readme Programs Versions || die
	doman Man/man1/* || die
	insinto /usr/include/wcstools
	doins libwcs/*.h || die
}
