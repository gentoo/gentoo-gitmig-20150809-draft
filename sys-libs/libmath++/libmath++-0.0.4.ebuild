# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libmath++/libmath++-0.0.4.ebuild,v 1.7 2006/05/24 23:35:31 halcy0n Exp $

inherit autotools

DESCRIPTION="template based math library, written in C++, for symbolic and numeric calculus applications"
HOMEPAGE="http://rm-rf.in/libmath%2B%2B/"
SRC_URI="http://upstream.rm-rf.in/libmath%2B%2B/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="ppc s390 x86 amd64"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_compile() {
	eautoreconf

	econf || die "configure failed"
	emake || die "make filed"

	if use doc ; then
		emake -C doc api-doc
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO

	if use doc ; then
		dohtml -r "${S}"/doc/user-api/*
	fi
}
