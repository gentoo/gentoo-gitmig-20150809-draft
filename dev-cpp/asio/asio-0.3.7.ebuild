# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/asio/asio-0.3.7.ebuild,v 1.4 2007/02/11 20:29:18 armin76 Exp $

inherit eutils

KEYWORDS="~amd64 x86"

DESCRIPTION="asynchronous network library"
HOMEPAGE="http://asio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="Boost-1.0"
SLOT="0"
IUSE="doc ssl"

DEPEND="ssl? ( dev-libs/openssl )
		>=dev-libs/boost-1.33.0"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-recursive_init.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc README

	if use doc ; then
		dohtml -r doc/*
	fi
}
