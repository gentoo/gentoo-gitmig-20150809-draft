# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.0.3.ebuild,v 1.4 2001/07/22 04:55:49 jerry Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${A}"
HOMEPAGE="http://www.ncftp.com/"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make
}

src_install() {
    dodir /usr/share
    try make prefix=${D}/usr mandir=${D}/usr/share/man install

    dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
        READLINE-README README WHATSNEW-3.0

    cd ${D}/usr/bin
    if [ ! -e /usr/bin/ftp ] ;then
        ln -s ncftp ftp
    fi
}
