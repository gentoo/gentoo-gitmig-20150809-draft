# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/tclap/tclap-1.2.0.ebuild,v 1.1 2010/06/08 19:41:41 vostorga Exp $

EAPI=2
inherit eutils

DESCRIPTION="Simple templatized C++ library for parsing command line arguments."
HOMEPAGE="http://tclap.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )"

src_configure() {
	local myconf="$(use_enable doc doxygen)"
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		dohtml -r docs/html/*
	fi
}
