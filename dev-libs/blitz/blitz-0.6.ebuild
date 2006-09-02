# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/blitz/blitz-0.6.ebuild,v 1.9 2006/09/02 21:20:43 wormo Exp $

DESCRIPTION="High-performance C++ numeric library"
SRC_URI="mirror://sourceforge/${PN/-/}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.oonumerics.org/blitz"
DEPEND="icc? ( dev-lang/icc )"
IUSE="icc"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

src_compile() {

	# default to gcc
	local myconf="--with-cxx=gcc"
	# ICC: if we've got it, use it
	use icc && myconf="--with-cxx=icc"
	# oops, they're not in the distribution, but the build requires them
	touch NEWS AUTHORS
	./configure ${myconf} --prefix=${D}/usr
	emake || die
	emake check-testsuite || die
}

src_install () {

	emake install || die
	cd ${S}
	dodoc ChangeLog ChangeLog.1 LICENSE README README.binutils TODO COPYING LEGAL
	cd ${D}/usr
	dohtml -r doc/blitz
	rm -rf ${D}/usr/doc
	rm -rf ${D}/usr/demos
	rm -rf ${D}/usr/testsuite
	rm ${D}/usr/include/random/Makefile.am
	rm ${D}/usr/examples/Makefile
	mv benchmarks examples ${D}/usr/share/doc/${P}
}
