# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/delay/delay-1.6.ebuild,v 1.1 2002/08/01 19:50:52 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Delay is a sleeplike program that counts down the number of seconds specified on its command line."
HOMEPAGE="http://onegeek.org/~tom/software/delay/"
KEYWORDS="x86"
SRC_URI="http://onegeek.org/~tom/software/delay/dl/${P}.tar.gz" 
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
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
