# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/krb5/krb5-1.2.2.ebuild,v 1.3 2001/07/15 18:58:16 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}/src
SRC_URI="http://www.crypto-publish.org/dist/mit-kerberos5/${A}"
DESCRIPTION="MIT Kerberos V (set up for pam)"
HOMEPAGE="http://crypto-publish.org"

DEPEND="virtual/glibc"


src_compile() {

    try ./configure --with-krb4 --enable-shared --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    mv Makefile Makefile.orig
    #Don't install the ftp, telnet, r* apps; use pam instead
    sed -e 's/ appl //' Makefile.orig > Makefile
    try make

}

src_install () {

    try make DESTDIR=${D} install
    cd ..
    dodoc README
    echo 'NOTE: ftp, telnet, r* apps not installed.  Install pam-krb5!'

}

