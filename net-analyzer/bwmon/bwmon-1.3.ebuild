# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bwmon/bwmon-1.3.ebuild,v 1.1 2002/06/15 07:32:46 lostlogic Exp $

DESCRIPTION="Simple ncurses bandwidth monitor"
HOMEPAGE="http://bwmon.sourceforge.net/"
LICENSE="GPL"
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
SLOT="0"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
S=${WORKDIR}/${P}

src_unpack() {

	unpack ${A}
	cd ${S}
	sed -e "s:/usr/local/bin:\$\{DESTDIR\}usr/bin:" \
	    Makefile > Makefile.hacked
	mv Makefile.hacked Makefile
	sed -e "s:CFLAGS =:CFLAGS = ${CFLAGS}:" \
	    -e "s:LDFLAGS =:LDFLAGS = -L/lib:" \
	    src/Makefile > src/Makefile.hacked
	mv src/Makefile.hacked src/Makefile
	
}


src_compile() {

	emake || die

}

src_install () {

	dodir /usr/bin
	make DESTDIR=${D} install || die
	dodoc README
}
