# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/rrs/rrs-1.70.ebuild,v 1.10 2012/10/11 09:08:55 pinkbyte Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Reverse Remote Shell"
HOMEPAGE="http://www.cycom.se/dl/rrs"
SRC_URI="http://www.cycom.se/uploads/36/19/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	local target=""
	use ssl || target="-nossl"

	sed -i -e "s/-s //g" Makefile || die
	emake generic${target} CFLAGS="${CFLAGS}" LDEXTRA="${LDFLAGS}" \
		CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin rrs || die
	dodoc CHANGES README
	doman rrs.1
}
