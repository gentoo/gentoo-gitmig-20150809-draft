# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/lrslib/lrslib-042c.ebuild,v 1.1 2010/11/12 18:43:10 tomka Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="self-contained ANSI C implementation of the reverse search algorithm"
HOMEPAGE="http://cgm.cs.mcgill.ca/~avis/C/lrs.html"
SRC_URI="http://cgm.cs.mcgill.ca/~avis/C/lrslib/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gmp"

DEPEND="gmp? ( dev-libs/gmp )"
RDEPEND="${DEPEND}"

src_prepare(){
	sed -i "s/gcc/$(tc-getCC)/g" makefile
	sed -i "s/-O3/${CFLAGS} ${LDFLAGS}/g" makefile
}

src_compile () {
	if use amd64 ; then
		emake all64 || die "make failed"
	else
		emake || die "make failed"
	fi
	if use gmp ; then
		emake gmp || die "make failed"
	fi
}

src_install() {
	dobin lrs redund redund1 buffer
	if use x86; then
		dobin nash setupnash setupnash2 2nash
		# Prevent clash with cddlib:
		newbin fourier lrsfourier
	fi
	use gmp && dobin glrs gnash gredund gfourier
	dodoc readme
	dohtml lrslib.html
}
