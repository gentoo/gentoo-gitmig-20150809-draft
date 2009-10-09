# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/tokyocabinet/tokyocabinet-1.4.34-r1.ebuild,v 1.1 2009/10/09 23:40:56 patrick Exp $

EAPI=2

inherit eutils

DESCRIPTION="A library of routines for managing a database"
HOMEPAGE="http://1978th.net/tokyocabinet/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples"

DEPEND="sys-libs/zlib
	app-arch/bzip2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/fix_rpath.patch"
}

src_configure() {
	econf \
		--enable-fastest \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"

	if use examples; then
		dodoc example/* || die "Install failed"
	fi

	if use doc; then
		dodoc doc/* || die "Install failed"
	fi
}

src_test() {
	emake -j1 check || die "Tests failed"
}