# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.2.ebuild,v 1.3 2000/11/01 04:44:16 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A ASCI-Graphics Library"
SRC_URI="ftp://ftp.ta.jcu.cz/pub/aa/${A}"
HOMEPAGE="http://www.ta.jcu.cz/aa/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1
	>=sys-libs/slang-1.4.2
	>=x11-base/xfree-4.0.1"

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

