# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stone/stone-2.2e.ebuild,v 1.1 2005/02/28 14:46:44 matsuu Exp $

DESCRIPTION="A simple TCP/IP packet repeater"
HOMEPAGE="http://www.gcd.org/sengoku/stone/"
SRC_URI="http://www.gcd.org/sengoku/stone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
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
