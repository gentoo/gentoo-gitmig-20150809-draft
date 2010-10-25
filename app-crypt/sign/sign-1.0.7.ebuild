# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/sign/sign-1.0.7.ebuild,v 1.11 2010/10/25 18:20:02 grobian Exp $

inherit toolchain-funcs eutils

DESCRIPTION="File signing and signature verification utility"
HOMEPAGE="http://swapped.cc/sign/"
SRC_URI="http://swapped.cc/${PN}/files/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	has_version ">=dev-libs/openssl-0.9.8" && epatch "${FILESDIR}"/${PV}-openssl-0.9.8.patch
	epatch "${FILESDIR}"/${PV}-as-needed.patch
	# remove -g from CFLAGS, it happens to break the build on ppc-macos
	sed -i -e 's/-g//' src/Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin sign || die "dobin failed"
	doman man/sign.1 || die "doman failed"
	dodoc README || die "dodoc failed"
	dosym sign /usr/bin/unsign || die "dosym failed"
}
