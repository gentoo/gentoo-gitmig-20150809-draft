# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/scsign/scsign-0.0.5.ebuild,v 1.7 2008/11/26 02:50:14 flameeyes Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Scsign - a command-line utility to digitally sign a file"
HOMEPAGE="http://opensignature.sourceforge.net/"
SRC_URI="mirror://sourceforge/opensignature/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""
S="${WORKDIR}"

DEPEND=">=dev-libs/opensc-0.8.1
	dev-libs/openssl
	sys-apps/pcsc-lite"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-printid.patch"
}

src_compile() {
	$(tc-getCC) -pthread ${CFLAGS} ${LDFLAGS} main.c libscsign.c -o scsign -lcrypto -lpcsclite -lopensc || die "build failed"
}

src_install() {
	dobin scsign || die "dobin failed"
}
