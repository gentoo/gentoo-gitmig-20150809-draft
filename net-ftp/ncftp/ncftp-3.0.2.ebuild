# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ncftp/ncftp-3.0.2.ebuild,v 1.2 2000/12/22 17:51:19 jerry Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An extremely configurable ftp client"
SRC_URI="ftp://ftp.ncftp.com/ncftp/${A}"
HOMEPAGE="http://www.ncftp.com/"

DEPEND=">=sys-libs/glibc-2.1.3"

src_compile() {
    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST}
    try make
}

src_install () {
    cd ${S}
    try make prefix=${D}/usr install

    dodoc CHANGELOG FIREWALL-PROXY-README LICENSE.txt
        READLINE-README README WHATSNEW-3.0
}
