# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/nylon/nylon-1.21.ebuild,v 1.4 2007/04/24 18:39:06 dertobi123 Exp $

DESCRIPTION="A lightweight SOCKS proxy server"
HOMEPAGE="http://monkey.org/~marius/nylon/"
SRC_URI="http://monkey.org/~marius/nylon/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=dev-libs/libevent-0.6"

src_install() {
	einstall || die "make install failed"
	dodoc README THANKS

	insinto /etc ; doins "${FILESDIR}/nylon.conf"
	newinitd "${FILESDIR}/nylon.init" nylond
}
