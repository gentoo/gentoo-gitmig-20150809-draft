# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.13.ebuild,v 1.12 2004/06/28 16:05:39 vapier Exp $

inherit eutils

DESCRIPTION="A command to eject a disc from the CD-ROM drive"
HOMEPAGE="http://eject.sourceforge.net/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc mips alpha hppa amd64 ia64 ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Get this puppy working with kernel 2.5.x
	# <azarah@gentoo.org> (06 March 2003)
	epatch ${FILESDIR}/${P}-kernel25-support.patch || die

	# Fix stupid includes (bug #41856)
	sed -i -e 's|-I/usr/src/linux -I/usr/src/linux|-I/usr/include|' \
		${S}/Makefile.in
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
