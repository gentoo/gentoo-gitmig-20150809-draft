# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.5a-r1.ebuild,v 1.2 2000/08/16 04:37:58 drobbins Exp $

P=openssl-0.9.5a
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="http://www.openssl.org/source/openssl-0.9.5a.tar.gz"
HOMEPAGE="http://www.opensl.org/"


src_compile() {                           
    ./config --prefix=/usr --openssldir=/usr/ssl threads
   cp Makefile Makefile.orig
   sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" Makefile.orig > Makefile
   make
}

src_install() {                               
    make INSTALL_PREFIX=${D} install
    mv ${D}/usr/ssl/man ${D}/usr
    prepman
    dodoc CHANGES* FAQ LICENSE NEWS README
    dodoc doc/*.txt
    docinto html
    dodoc doc/*.gif doc/*.html
    insinto /usr/share/emacs/site-lisp
    doins doc/c-indentation.el
}



