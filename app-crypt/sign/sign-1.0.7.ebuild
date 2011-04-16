# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/sign/sign-1.0.7.ebuild,v 1.12 2011/04/16 04:30:25 ssuominen Exp $

inherit toolchain-funcs eutils

DESCRIPTION="File signing and signature verification utility"
HOMEPAGE="http://swapped.cc/sign/"
SRC_URI="http://swapped.cc/${PN}/files/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-libs/openssl-0.9.8"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PV}-openssl-0.9.8.patch
	epatch "${FILESDIR}"/${PV}-as-needed.patch
	# remove -g from CFLAGS, it happens to break the build on ppc-macos
	sed -i -e 's/-g//' src/Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin sign || die
	doman man/sign.1 || die
	dodoc README || die
	dosym sign /usr/bin/unsign || die
}
