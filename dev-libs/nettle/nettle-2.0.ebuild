# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nettle/nettle-2.0.ebuild,v 1.7 2010/01/14 21:26:17 fauli Exp $

EAPI="2"

inherit autotools

DESCRIPTION="cryptographic library that is designed to fit easily in any context"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc s390 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="gmp ssl"

DEPEND="gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	!<dev-libs/lsh-1.4.3-r1"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e '/CFLAGS/s:-ggdb3::' \
		configure.ac || die "sed configure.ac failed"
	eautoreconf
}

src_configure() {
	econf \
		--enable-shared \
		$(use_enable gmp public-key) \
		$(use_enable ssl openssl)
}

src_install() {
	emake DESTDIR="${D}" install  || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
