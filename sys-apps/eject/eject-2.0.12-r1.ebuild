# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.12-r1.ebuild,v 1.1 2003/03/03 10:06:58 aliz Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="A command to eject a disc from the CD-ROM drive"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"
HOMEPAGE="http://eject.sourceforge.net/"
KEYWORDS="x86 ppc sparc alpha"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.security.patch 
}

src_install() {
	dodir /usr/bin /usr/share/man/man1

# Full install breaks sandbox, and I'm too lazy to figure out how, so:

	make DESTDIR=${D} install-binPROGRAMS || die
	make DESTDIR=${D} install-man1 || die
	make DESTDIR=${D} install-man || die

	dodoc ChangeLog COPYING README PORTING TODO 
	dodoc AUTHORS NEWS PROBLEMS
}
