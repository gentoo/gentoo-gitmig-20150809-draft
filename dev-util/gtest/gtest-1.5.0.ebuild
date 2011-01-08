# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtest/gtest-1.5.0.ebuild,v 1.7 2011/01/08 21:36:11 maekke Exp $

EAPI="3"
PYTHON_DEPEND="2"
inherit autotools eutils python

DESCRIPTION="Google C++ Testing Framework"
HOMEPAGE="http://code.google.com/p/googletest/"
SRC_URI="http://googletest.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm ~hppa x86 ~ppc-macos"
IUSE="examples threads static-libs"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -i -e "s|/tmp|${T}|g" test/gtest-filepath_test.cc || die "sed failed"

	python_convert_shebangs -r 2 .

	epatch "${FILESDIR}/${P}-asneeded.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with threads pthreads) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc CHANGES CONTRIBUTORS README || die

	if ! use static-libs ; then
		rm "${ED}"/usr/lib*/*.la || die
	fi

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins samples/*.{cc,h} || die
	fi
}
