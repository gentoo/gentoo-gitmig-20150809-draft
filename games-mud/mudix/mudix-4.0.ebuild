# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mudix/mudix-4.0.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A small, stable MUD client for the console"
SRC_URI="http://dwizardry.dhs.org/mudix/mudix-4.0.tar.gz"
HOMEPAGE="http://dwizardry.dhs.org/mudix.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_compile() {
	./configure --host=${CHOST}				\
		--prefix=/usr --sysconfdir=/etc			\
		--localstatedir=/var/lib || die

	emake || die
}

src_install () {
	dobin mudix
	dodoc README sample.usr
}

