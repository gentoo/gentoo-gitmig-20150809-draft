# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigsegv/libsigsegv-2.0.ebuild,v 1.1 2003/09/04 04:08:25 mkennedy Exp $

DESCRIPTION="GNU libsigsegv is a library for handling page faults in user mode."
HOMEPAGE="ftp://ftp.gnu.org/pub/gnu/libsigsegv/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/libsigsegv/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X gnome"

DEPEND="virtual/glibc"

S=${WORKDIR}/${P}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--enable-shared \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
	make check || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog* INSTALL NEWS PORTING README*
}
