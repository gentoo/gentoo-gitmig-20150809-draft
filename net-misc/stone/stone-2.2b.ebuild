# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stone/stone-2.2b.ebuild,v 1.1 2004/01/01 05:12:01 matsuu Exp $

DESCRIPTION="A simple TCP/IP packet repeater"
HOMEPAGE="http://www.gcd.org/sengoku/stone/"
SRC_URI="http://www.gcd.org/sengoku/stone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${P}

src_compile() {
	if [ "`use ssl`" ] ; then
		emake \
			CFLAGS="${CFLAGS}" \
			SSL=/usr \
			SSL_FLAGS="-DUSE_SSL -I/usr/include/openssl" \
			SSL_LIBS="-ldl -L/usr/lib -lssl -lcrypto" \
			linux-ssl || die
	else
		emake \
			CFLAGS="${CFLAGS}" \
			linux || die
	fi
}

src_install() {
	dobin stone
	doman stone.1
	dodoc README*
}
