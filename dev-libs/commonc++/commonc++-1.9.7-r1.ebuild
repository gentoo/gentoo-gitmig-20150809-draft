# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
#

S=${WORKDIR}/CommonC++-1.9.7
DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for\ 
threading, sockets, file access, daemons, persistence, serial I/O, XML parsing,\
and system services"
SRC_URI="http://ftp.azc.uam.mx/mirrors/gnu/commonc++/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commonc++/"


DEPEND="virtual/glibc
	sys-libs/zlib
	dev-libs/libxml2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/commmonc++-0.1.patch || die

}
src_compile() {

    cd ${S}
    ./configure \
		--prefix=/usr --host=${CHOST} \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		|| die "./configure failed"
    emake ||:

}

src_install () {

    make DESTDIR=${D} install || die
	dodoc AUTHORS INSTALL NEWS OVERVIEW.TXT ChangeLog\
		  README THANKS TODO COPYING COPYING.addendum
	dohtml doc/*
}
