# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/6tunnel/6tunnel-0.10.ebuild,v 1.1 2004/11/21 21:04:03 dragonheart Exp $

IUSE=""
DESCRIPTION="TCP proxy for applications that don't speak IPv6"
HOMEPAGE="http://toxygen.net/6tunnel"
SRC_URI="http://toxygen.net/6tunnel/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~s390"
DEPEND="virtual/libc"


src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin 6tunnel
	doman 6tunnel.1
	dodoc README CHANGELOG
}



