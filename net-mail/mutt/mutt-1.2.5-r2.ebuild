# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-mail/mutt/mutt-1.2.5-r2.ebuild,v 1.1 2000/12/20 09:45:34 drobbins Exp $

P=mutt-1.2.5-1
A=mutt-1.2.5i.tar.gz
S=${WORKDIR}/mutt-1.2.5
DESCRIPTION="a small but very powerful text-based mail client"
SRC_URI="ftp://ftp.mutt.org/pub/mutt/${A}"
HOMEPAGE="http://www.mutt.org"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-libs/slang-1.4.2
	>=dev-libs/openssl-0.9.6"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --sysconfdir=/etc/mutt --host=${CHOST} \
	--with-slang --with-regex --with-catgets \
	--enable-pop --enable-imap --with-ssl --enable-nfs-fix \
	--with-homespool=Maildir
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    prepman
    dodir /usr/doc/${P}
    mv ${D}/usr/doc/mutt/* ${D}/usr/doc/${P}
    rm -rf ${D}/usr/doc/mutt
    gzip ${D}/usr/doc/${P}/html/*
    gzip ${D}/usr/doc/${P}/samples/*
    gzip ${D}/usr/doc/${P}/*
	insinto /etc/mutt
	doins ${FILESDIR}/Muttrc*
}




