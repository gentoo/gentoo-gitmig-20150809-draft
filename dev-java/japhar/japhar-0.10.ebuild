# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Tools Team <tools@gentoo.org>
# Author: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-java/japhar/japhar-0.10.ebuild,v 1.1 2002/02/10 21:16:49 karltk Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Free Java Virtual Machine (JVM)"
SRC_URI="ftp://ftp.japhar.org/pub/hungry/japhar/source/${P}.tar.gz"
HOMEPAGE="http://www.japhar.org/"

DEPEND="virtual/glibc
	virtual/X11
	>=sys-libs/zlib-1.1.3
	>=dev-libs/nspr-4.1.2"
RDEPEND="$DEPEND"

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
}
