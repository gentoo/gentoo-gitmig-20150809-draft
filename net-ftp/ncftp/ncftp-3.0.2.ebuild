# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.0.2.ebuild,v 1.3 2001/05/28 05:24:13 achim Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${A}"
HOMEPAGE="http://www.ncftp.com/"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    
    try make prefix=${D}/usr install

    dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
        READLINE-README README WHATSNEW-3.0
}
