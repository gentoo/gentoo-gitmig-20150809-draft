# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Luke Graham <luke@trolltech.com>
# Maintainer: Tool Team <tools@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/indent/indent-2.2.6.ebuild,v 1.1 2001/11/14 15:22:19 hallski Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Indent program source files"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org"

DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS COPYING NEWS README* 
}
