# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/maildrop/maildrop-1.2.2.ebuild,v 1.2 2000/11/02 18:05:56 jerry Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Mail delivery agent/filter"
SRC_URI="http://download.sourceforge.net/courier/${A}"
HOMEPAGE="http://www.flounder.net/~mrsam/maildrop/index.html"

DEPEND=">=sys-libs/gdbm-1.8.0
        >=sys-libs/glibc-2.1.3"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
        --disable-tempdir --enable-syslog=1 --with-etcdir=/etc/maildrop \
        --enable-maildirquota --enable-userdb
        
    try make
}

src_install () {
    cd ${S}/maildrop
    insopts -o root -g root -m 4755
    insinto /usr/bin
    for i in maildrop dotlock
    do
      doins $i
    done

    insopts -o root -g root -m 755
    insinto /usr/bin
    doins reformail

    cd ${S}/rfc2045
    insopts -o root -g root -m 755
    insinto /usr/bin
    for i in makemime reformime
    do
      doins $i
    done

    cd ${S}/maildir
    insopts -o root -g root -m 755
    insinto /usr/bin
    for i in deliverquota maildirmake
    do
      doins $i
    done

    cd ${S}/makedat
    insopts -o root -g root -m 755
    insinto /usr/bin
    for i in makedat makedatprog
    do
      doins $i
    done

    cd ${S}/userdb
    insopts -o root -g root -m 755
    insinto /usr/bin
    donewins userdb.pl userdb
    for i in makeuserdb pw2userdb userdbpw vchkpw2userdb
    do
      doins $i
    done

    cd ${S}
    dodoc *.html
    doman *.1
    doman *.5
    doman *.8

    dodir /etc/maildrop
}
