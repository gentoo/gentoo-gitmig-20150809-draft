# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mudix/mudix-4.0.ebuild,v 1.3 2004/06/24 23:00:52 agriffis Exp $

DESCRIPTION="A small, stable MUD client for the console"
HOMEPAGE="http://dwizardry.dhs.org/mudix.html"
SRC_URI="http://dwizardry.dhs.org/mudix/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="virtual/glibc
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
