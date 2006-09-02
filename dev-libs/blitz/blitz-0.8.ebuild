# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/blitz/blitz-0.8.ebuild,v 1.8 2006/09/02 21:20:43 wormo Exp $

inherit eutils toolchain-funcs

DESCRIPTION="High-performance C++ numeric library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.oonumerics.org/blitz"
DEPEND="virtual/tetex
	icc? ( dev-lang/icc )"
IUSE="icc"

SLOT="0"
KEYWORDS="~amd64 ppc x86"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/blitz-0.8-makefile.patch
}

src_compile() {
	local myconf
	# ICC: if we've got it, use it
	use icc && myconf="--with-cxx=icc" || myconf="--with-cxx=gcc"

	export CC=$(tc-getCC) CXX=$(tc-getCXX)
	econf ${myconf} || die "econf failed"
	if ! emake lib;
	then
		eerror 'If you got an error like "configure: error: Fortran 77 compiler cannot create executables'
		die "Remerge gcc with the fortran use flag"
	fi
}

src_test() {
	make check-testsuite || die "selftest failed"
}

src_install () {
	dodir /usr/share/doc/${PF}
	emake DESTDIR=${D} docdir=/usr/share/doc/${PF} install || \
		die "install failed - please include above output in a bug report to bugs.gentoo.org"
	dodoc ChangeLog ChangeLog.1 LICENSE README README.binutils \
	      TODO COPYING LEGAL AUTHORS NEWS
}
