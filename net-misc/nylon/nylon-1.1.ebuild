# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nylon/nylon-1.1.ebuild,v 1.6 2004/07/15 03:15:10 agriffis Exp $

DESCRIPTION="A lightweight SOCKS proxy server"
HOMEPAGE="http://monkey.org/~marius/nylon/"
SRC_URI="http://monkey.org/~marius/nylon/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=dev-libs/libevent-0.6"

src_install() {
	einstall || die
	dodoc README THANKS
	insinto /etc
	doins ${FILESDIR}/nylon.conf
}
