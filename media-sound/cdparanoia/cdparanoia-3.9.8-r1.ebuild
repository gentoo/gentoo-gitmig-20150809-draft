# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdparanoia/cdparanoia-3.9.8-r1.ebuild,v 1.1 2004/04/22 19:43:52 azarah Exp $

IUSE=

inherit eutils

MY_P=${PN}-III-alpha9.8
S=${WORKDIR}/${MY_P}
DESCRIPTION="an advanced CDDA reader with error correction"
SRC_URI="http://www.xiph.org/paranoia/download/${MY_P}.src.tgz"
HOMEPAGE="http://www.xiph.org/paranoia/"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64 ~mips"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	# cdda_paranoia.h should include cdda_interface_h, else most configure
	# scripts testing for support fails (gnome-vfs, etc).
	epatch ${FILESDIR}/${P}-include-cdda_interface_h.patch
}

src_compile() {
	./configure --prefix=/usr || die
	# The configure script doesn't recognize i686-pc-linux-gnu
	# --host=${CHOST}

	make OPT="${CFLAGS}" || die
}

src_install() {
	dodir /usr/{bin,lib,include} /usr/share/man/man1
	make prefix=${D}/usr \
		MANDIR=${D}/usr/share/man \
		install || die

	dodoc FAQ.txt GPL README
}

