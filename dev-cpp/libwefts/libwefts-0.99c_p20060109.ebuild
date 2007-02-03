# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libwefts/libwefts-0.99c_p20060109.ebuild,v 1.3 2007/02/03 21:41:05 flameeyes Exp $

inherit libtool

DESCRIPTION="A C++ high-level yet efficent multithreading library, portable across pthread-enabled platforms."

SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://wefts.sourceforge.net/"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE="doc debug"

src_unpack() {
	unpack ${A}
	cd ${S}

	elibtoolize
}

src_compile() {
	econf \
		$(use_enable doc) \
		$(use_enable debug) \
		${myconf} \
		--enable-shared \
		--disable-dependency-tracking \
		|| die "econf failed"

	emake || die "emake failed"
}

src_test() {
	einfo "Please ignore failures on test #5, it's platform-dependant."

	cd ${S}/testsuite
	emake || die "emake testsuite failed"
	./testsuite || die "Some tests failed."
}

src_install () {
	make DESTDIR=${D} install || die

	if use doc; then
		dohtml -r ${S}/doc/html/*
	fi
}

