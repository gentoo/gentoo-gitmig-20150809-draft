# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/eject/eject-2.0.13.ebuild,v 1.3 2004/02/19 19:51:46 azarah Exp $

inherit eutils

S="${WORKDIR}/${P}"
DESCRIPTION="A command to eject a disc from the CD-ROM drive"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/disk-management/${P}.tar.gz
	http://www.pobox.com/~tranter/${P}.tar.gz"
HOMEPAGE="http://eject.sourceforge.net/"

KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ppc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

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
