# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/nettle/nettle-1.13-r1.ebuild,v 1.3 2005/10/17 23:03:42 vapier Exp $

inherit eutils

DESCRIPTION="cryptographic library that is designed to fit easily in any context"
HOMEPAGE="http://www.lysator.liu.se/~nisse/nettle/"
SRC_URI="http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="gmp ssl"

DEPEND="gmp? ( dev-libs/gmp )
	ssl? ( dev-libs/openssl )
	!<dev-libs/lsh-1.4.3-r1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-preprocess-asm.patch
	epatch "${FILESDIR}"/${P}-no-exec-stack.patch
	epatch "${FILESDIR}"/${P}-PIC.patch
	sed -i \
		-e '/CFLAGS/s:-ggdb3::' \
		configure || die
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
