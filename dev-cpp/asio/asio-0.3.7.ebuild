# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/asio/asio-0.3.7.ebuild,v 1.1 2006/10/18 21:44:45 dev-zero Exp $

DESCRIPTION="asynchronous network library"
HOMEPAGE="http://asio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc ssl test"

DEPEND=">=dev-libs/boost-1.33.0
		test? ( ssl? ( dev-libs/openssl ) )"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README

	if use doc ; then
		dohtml -r doc/*
	fi
}
