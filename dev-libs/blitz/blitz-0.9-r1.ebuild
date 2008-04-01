# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/blitz/blitz-0.9-r1.ebuild,v 1.2 2008/04/01 15:48:32 dragonheart Exp $

inherit eutils toolchain-funcs fortran

DESCRIPTION="High-performance C++ numeric library"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.oonumerics.org/blitz"
IUSE="debug doc examples icc"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="|| ( GPL-2 Blitz-Artistic )"

DEPEND="icc? ( dev-lang/icc )
		doc? ( app-doc/doxygen )"
RDEPEND=""

FORTAN="g77"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/blitz-uninstalled.pc//' \
		Makefile.in || die "sed failed"
	epatch "${FILESDIR}"/${P}-gcc-4.3-missing-includes.patch
}

src_compile() {
	local myconf
	# ICC: if we've got it, use it
	use icc && myconf="--with-cxx=icc" || myconf="--with-cxx=gcc"

	export CC=$(tc-getCC) CXX=$(tc-getCXX)
	econf \
		--enable-shared \
		$(use_enable doc doxygen) \
		$(use_enable doc enable-html-docs) \
		$(use_enable debug) \
		${myconf} || die "econf failed"
}

src_test() {
	make check-testsuite || die "selftest failed"
}

src_install () {
	dodir /usr/share/doc/${PF}/html
	emake DESTDIR="${D}" docdir=/usr/share/doc/${PF}/html install || die "emake install failed"
	dodoc ChangeLog ChangeLog.1 README README.binutils TODO AUTHORS NEWS

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.cpp
	fi
}
