# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nettle/nettle-1.15.ebuild,v 1.7 2010/12/17 15:50:55 c1pher Exp $

inherit eutils autotools

DESCRIPTION="cryptographic library that is designed to fit easily in any context"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ppc s390 sparc x86 ~x86-fbsd"
IUSE="gmp ssl"

DEPEND="gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	!<dev-libs/lsh-1.4.3-r1"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.14-make-as-needed.patch"
	sed -i \
		-e '/CFLAGS/s:-ggdb3::' \
		configure.ac || die
	eautoreconf
}

src_compile() {
	econf \
		--enable-shared \
		$(use_enable ssl openssl) \
		$(use_enable gmp public-key) \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install  || die
	dodoc AUTHORS ChangeLog NEWS README
}
