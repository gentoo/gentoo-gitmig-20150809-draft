# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.2.ebuild,v 1.1 2000/10/18 03:20:23 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A ASCI-Graphics Library"
SRC_URI="ftp://ftp.ta.jcu.cz/pub/aa/${A}"
HOMEPAGE="http://"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	--with-slang-driver=yes
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*
    prepinfo
}

