# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

S=${WORKDIR}/${P}
DESCRIPTION="Icecast is an Internet based broadcasting system based on the Mpeg Layer III streaming technology."
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {

	local myconf

	use crypt && myconf="--with-crypt" || myconf="--without-crypt"

	./configure 	--with-libwrap              \
			${myconf}                   \
			--infodir=/usr/share/info   \
			--mandir=/usr/share/man     \
			--host=${CHOST} || die

	emake || die
}


src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS CHANGES COPYING FAQ INSTALL README TESTED TODO
}
