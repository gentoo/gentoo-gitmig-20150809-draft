# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stone/stone-2.2c.ebuild,v 1.5 2004/10/28 23:38:07 matsuu Exp $

DESCRIPTION="A simple TCP/IP packet repeater"
HOMEPAGE="http://www.gcd.org/sengoku/stone/"
SRC_URI="http://www.gcd.org/sengoku/stone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc ~sparc"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

src_compile() {
	if use ssl ; then
		emake \
			CFLAGS="${CFLAGS}" \
			SSL=/usr \
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
