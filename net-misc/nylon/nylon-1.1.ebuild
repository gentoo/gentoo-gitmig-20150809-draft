# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nylon/nylon-1.1.ebuild,v 1.2 2003/02/13 15:02:52 vapier Exp $

DESCRIPTION="A lightweight SOCKS proxy server"
HOMEPAGE="http://monkey.org/~marius/nylon/"
SRC_URI="http://monkey.org/~marius/nylon/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND=">=libevent-0.6"
RDEPEND=${DEPEND}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc README THANKS
	insinto /etc
	doins ${FILESDIR}/nylon.conf
}
