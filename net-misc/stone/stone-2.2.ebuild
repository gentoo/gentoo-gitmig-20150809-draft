# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stone/stone-2.2.ebuild,v 1.1 2003/09/08 16:50:19 avenj Exp $

DESCRIPTION="A simple TCP/IP packet repeater"
HOMEPAGE="http://www.gcd.org/sengoku/stone/"
SRC_URI="http://www.gcd.org/sengoku/stone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ssl"

DEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/${P}

src_compile() {
	if [ "`use ssl`" ] ; then
		emake \
			SSL=/usr \
			SSL_FLAGS="-DUSE_SSL -I/usr/include/openssl" \
			SSL_LIBS="-ldl -L/usr/lib -lssl -lcrypto" \
			linux-ssl || die
	else
		emake linux || die
	fi
}

src_install() {
	dobin stone
	doman stone.1
	dodoc README*
}
