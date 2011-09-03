# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nettle/nettle-2.3.ebuild,v 1.1 2011/09/03 00:17:00 radhermit Exp $

EAPI="4"

inherit autotools

DESCRIPTION="Low-level cryptographic library"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="|| ( LGPL-3 LGPL-2.1 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="gmp ssl"

DEPEND="gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e "/CFLAGS=/s: -ggdb3::" -i configure.ac || die "sed failed"
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		$(use_enable gmp public-key) \
		$(use_enable ssl openssl)
}
