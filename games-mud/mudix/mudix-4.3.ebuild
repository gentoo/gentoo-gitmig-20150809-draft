# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mudix/mudix-4.3.ebuild,v 1.1 2004/12/21 12:06:20 absinthe Exp $

DESCRIPTION="A small, stable MUD client for the console"
HOMEPAGE="http://dw.nl.eu.org/mudix.html"
SRC_URI="http://dw.nl.eu.org/mudix/${P}.tar.gz"

KEYWORDS="~x86 ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/ncurses-5.2"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr --sysconfdir=/etc \
		--localstatedir=/var/lib || die

	emake || die "emake failed"
}

src_install () {
	dobin mudix
	dodoc README sample.usr
}
