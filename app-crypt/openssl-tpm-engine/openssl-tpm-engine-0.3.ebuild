# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/openssl-tpm-engine/openssl-tpm-engine-0.3.ebuild,v 1.1 2006/05/07 05:46:38 dragonheart Exp $

inherit autotools eutils

MY_P="${P/-tpm-/_tpm_}"

DESCRIPTION="This provides a OpenSSL engine that uses private keys stored in TPM hardware"
HOMEPAGE="http://trousers.sourceforge.net"
SRC_URI="mirror://sourceforge/trousers/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""
DEPEND=">=dev-libs/openssl-0.9.8"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${P}-openssl.patch"
	eautoreconf || die 'eautoreconf failed'
}

src_compile() {
	econf OPENSSL_LIB_DIR=/usr/lib OPENSSL_INCLUDE_DIR=/usr/include/openssl || die 'configure failed'
	emake || die 'make failed'
}

src_install() {
	make DESTDIR="${D}" install || die 'install failed'
	dodoc openssl.cnf.sample README
}
