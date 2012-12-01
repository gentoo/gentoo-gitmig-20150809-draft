# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslwrap/sslwrap-2.0.6-r1.ebuild,v 1.6 2012/12/01 19:37:27 armin76 Exp $

inherit eutils

DESCRIPTION="TSL/SSL - Port Wrapper"
HOMEPAGE="http://quiltaholic.com/rickk/sslwrap/"
SRC_URI="http://quiltaholic.com/rickk/sslwrap/${PN}${PV/.0./0}.tar.gz
	mirror://gentoo/${PN}-gentoo.tar.bz2"

LICENSE="sslwrap"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}${PV//.}

src_unpack () {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		-e "s:/usr/local/ssl/include:/usr/include/openssl:" \
		Makefile
	cp "${WORKDIR}/${PN}-gentoo/*.c" "${S}"
	has_version '=dev-libs/openssl-0.9.7*' \
		&& epatch "${FILESDIR}/${PV}-openssl-0.9.7.patch"
	sed -i \
		-e "s:OPENSSL\":\"openssl\/:g" \
		-e "s:SSL_OP_NON_EXPORT_FIRST:SSL_OP_CIPHER_SERVER_PREFERENCE:g" \
		*.h *.c
}

src_install() {
	dosbin sslwrap
	dodoc README
	dohtml -r ./
}
