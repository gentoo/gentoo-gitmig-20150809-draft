# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/blitz/blitz-0.9.ebuild,v 1.2 2006/09/02 21:20:43 wormo Exp $

inherit eutils toolchain-funcs fortran

DESCRIPTION="High-performance C++ numeric library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.oonumerics.org/blitz"
DEPEND="virtual/tetex
	icc? ( dev-lang/icc )"
IUSE="icc"

SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
LICENSE="GPL-2"

FORTAN="g77"

src_compile() {
	local myconf
	# ICC: if we've got it, use it
	use icc && myconf="--with-cxx=icc" || myconf="--with-cxx=gcc"

	export CC=$(tc-getCC) CXX=$(tc-getCXX)
	econf ${myconf} || die "econf failed"
}

src_test() {
	make check-testsuite || die "selftest failed"
}

src_install () {
	dodir /usr/share/doc/${PF}
	emake DESTDIR=${D} docdir=/usr/share/doc/${PF} install || die
	dodoc ChangeLog ChangeLog.1 LICENSE README README.binutils \
	      TODO COPYING LEGAL AUTHORS NEWS
}
