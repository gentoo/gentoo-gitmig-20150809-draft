# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim/naim-0.11.2.ebuild,v 1.4 2002/07/17 09:08:09 seemant Exp $

S=${WORKDIR}/${P}
SRC_URI="http://dev.n.ml.org/${P}.tar.gz"
DESCRIPTION="An ncurses AOL Instant Messenger."
HOMEPAGE="http://naim.n.ml.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-libs/ncurses-5.2"

src_compile() {

	cd ${S}
	./configure --prefix=/usr --host=${CHOST} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	
	dodoc AUTHORS ChangeLog NEWS README TODO VERSIONS
}
