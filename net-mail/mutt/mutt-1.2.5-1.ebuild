# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.2.5-1.ebuild,v 1.4 2000/08/16 04:38:16 drobbins Exp $

P=mutt-1.2.5-1
A=mutt-1.2.5i.tar.gz
S=${WORKDIR}/mutt-1.2.5
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/pub/mutt/${A}"
HOMEPAGE="http://www.mutt.org"


src_compile() {

    cd ${S}
    ./configure --prefix=/usr --sysconfdir=/etc/mutt --host=${CHOST} \
	--with-slang --with-regex --with-catgets \
	--enable-pop --enable-imap --with-ssl --enable-nfs-fix \
	--with-homespool=Maildir
    make

}

src_install () {

    cd ${S}
    make DESTDIR=${D} install
    prepman
    dodir /usr/doc/${P}
    mv ${D}/usr/doc/mutt/* ${D}/usr/doc/${P}
    rm -rf ${D}/usr/doc/mutt
    gzip ${D}/usr/doc/${P}/html/*
    gzip ${D}/usr/doc/${P}/samples/*
    gzip ${D}/usr/doc/${P}/*
}



