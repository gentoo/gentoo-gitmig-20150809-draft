# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/delay/delay-1.6.ebuild,v 1.8 2004/06/19 19:40:16 kugelfang Exp $

DESCRIPTION="Delay is a sleeplike program that counts down the number of seconds specified on its command line."
HOMEPAGE="http://onegeek.org/~tom/software/delay/"
IUSE=""
KEYWORDS="x86 ppc ~amd64"
SRC_URI="http://onegeek.org/~tom/software/delay/dl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	sed -i -e "s/#include <stdio.h>/&\n#include <stdlib.h>/" delay.c
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README COPYING INSTALL
}
