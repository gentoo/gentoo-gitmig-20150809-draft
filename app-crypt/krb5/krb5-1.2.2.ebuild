# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Grant Goodyear <grant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/krb5/krb5-1.2.2.ebuild,v 1.2 2001/06/24 02:20:29 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
SRC_URI="http://www.crypto-publish.org/dist/mit-kerberos5/${A}"
DESCRIPTION="MIT Kerberos V (set up for pam)"
HOMEPAGE="http://crypto-publish.org"

DEPEND="virtual/glibc"


src_compile() {

    cd ${S}/src
    try ./configure --with-krb4 --enable-shared --prefix=/usr --host=${CHOST}
    mv Makefile Makefile.orig
    #Don't install the ftp, telnet, r* apps; use pam instead
    sed -e 's/ appl //' Makefile.orig > Makefile
    try make

}

src_install () {

    cd ${S}/src
    try make DESTDIR=${D} install
    cd ..
    dodoc README
    echo 'NOTE: ftp, telnet, r* apps not installed.  Install pam-krb5!'

}

