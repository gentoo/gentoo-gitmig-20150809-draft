# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/openssl/openssl-0.9.6.ebuild,v 1.4 2000/11/02 05:59:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Toolkit for SSL v2/v3 and TLS v1"
SRC_URI="http://www.openssl.org/source/${A}"
HOMEPAGE="http://www.opensl.org/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3"

src_compile() {                           
    ./config --prefix=/usr --openssldir=/usr/ssl threads
   cp Makefile Makefile.orig
   sed -e "s/-O3/$CFLAGS/" -e "s/-m486//" \
       -e "s:/usr/local/bin/perl:/usr/bin/perl:" Makefile.orig > Makefile
   try make shlib
}

src_install() {                               
    try make INSTALL_PREFIX=${D} install

    dolib.so shlib_dir/libcrypto.so.0.9.4
    dolib.so shlib_dir/libssl.so.0.9.4
    preplib /usr
    mv ${D}/usr/ssl/man ${D}/usr
    dodoc CHANGES* FAQ LICENSE NEWS README
    dodoc doc/*.txt
    docinto html
    dodoc doc/*.gif doc/*.html
    insinto /usr/share/emacs/site-lisp
    doins doc/c-indentation.el
}



