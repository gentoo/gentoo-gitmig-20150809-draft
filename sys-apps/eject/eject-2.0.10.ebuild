# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.6.ebuild,v 1.3 2001/12/31 23:47:55 azarah Exp

S=${WORKDIR}/${P}
DESCRIPTION="A command to eject a disc from the CD-ROM drive"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz"
HOMEPAGE="http://www.pobox.com/~tranter/eject.html"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man || die
	make || die
}

src_install () {
	dodir /usr/bin /usr/share/man/man1

# Full install breaks sandbox, and I'm too lazy to figure out how, so:

	make DESTDIR=${D} install-binPROGRAMS || die
	make DESTDIR=${D} install-man1 || die
	make DESTDIR=${D} install-man || die

	dodoc ChangeLog COPYING README PORTING TODO 
	dodoc AUTHORS NEWS PROBLEMS
}
