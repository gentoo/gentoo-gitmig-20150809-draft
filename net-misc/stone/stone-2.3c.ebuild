# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/stone/stone-2.3c.ebuild,v 1.1 2008/01/27 16:02:33 matsuu Exp $

inherit toolchain-funcs

DESCRIPTION="A simple TCP/IP packet repeater"
HOMEPAGE="http://www.gcd.org/sengoku/stone/"
SRC_URI="http://www.gcd.org/sengoku/stone/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ssl"

DEPEND="ssl? ( dev-libs/openssl )"

src_compile() {
	if use ssl ; then
		emake \
			CC=$(tc-getCC) \
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
