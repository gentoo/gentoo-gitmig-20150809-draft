# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-dialup/minicom/minicom-1.83.1-r1.ebuild,v 1.4 2002/07/17 22:16:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Serial Communication Program"
SRC_URI="http://www.clinet.fi/~walker/${P}.src.tar.gz"
HOMEPAGE="http://www.clinet.fi/~walker/minicom.html"

DEPEND=">=sys-libs/ncurses-5.2-r3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {

	unpack ${A}
	cd ${S}/src
	cp Makefile Makefile.orig
	sed -e "s:^FLAGS\t=.*$:FLAGS\t= -Wall -D_POSIX -D_SYSV -D_SELECT -pipe # -I/usr/include/ncurses ${CFLAGS}:" \
		sed -e "s:^LFLAGS\t=.*$:LFLAGS\t= -s ${CFLAGS}:" \
		sed -e "s:^CC\t=.*$:CC\t= gcc:" \
		sed -e "s:^LIBDIR\t=.*$:LIBDIR\t= /etc/minicom:" \
			Makefile.orig > Makefile

	cp dial.c dial.c.orig
	sed -e "s:<sys/time.h>:<time.h>:" \
		dial.c.orig > dial.c

	cp common.c common.c.orig
	sed -e "s:#include <stdarg.h>:#include <stdarg.h>\n#include <time.h>:" \
		common.c.orig > common.c

	cp po/Makefile po/Makefile.orig
	sed -e 's:ko.mo::g' \
		po/Makefile.orig > po/Makefile
	
}

src_compile() {

	cd src 
	make || die

}

src_install() {

	dobin src/minicom src/ascii-xfr src/runscript
	doman man/minicom.1 man/ascii-xfr.1 man/runscript.1
	dodoc doc/minicom.FAQ
	docinto scripts
	dodoc demos/*
	exeinto /usr/bin
	doexe src/xminicom
	insinto /etc/minicom
	doins ${FILESDIR}/minirc.dfl 
	
	dodoc Readme Copyright

}
