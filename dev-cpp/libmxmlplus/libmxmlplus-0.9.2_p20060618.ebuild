# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libmxmlplus/libmxmlplus-0.9.2_p20060618.ebuild,v 1.1 2006/06/18 01:23:50 flameeyes Exp $

inherit libtool

DESCRIPTION="Minimal XML DOM Library"

SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://mxml.sourceforge.net/"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

src_unpack() {
	unpack ${A}
	elibtoolize
}

src_compile() {
	econf \
		--enable-shared \
		$(use_enable doc) \
		--disable-dependency-tracking || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR=${D} install || die

	if use doc; then
		dodir /usr/share/doc/${PF}
		dohtml -r ${S}/doc/html/*
	fi
}
