# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.2.ebuild,v 1.3 2002/07/11 06:30:46 drobbins Exp $

S=${WORKDIR}/${P}
SRC_URI="http://dev.n.ml.org/${P}.tar.gz"
DESCRIPTION="An ncurses AOL Instant Messenger."
HOMEPAGE="http://naim.n.ml.org/"
SLOT="0"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

src_unpack() {

	unpack ${P}.tar.gz

}

src_compile() {

	cd ${S}
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

}
