# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.2-r1.ebuild,v 1.4 2001/03/06 05:27:28 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A ASCI-Graphics Library"
SRC_URI="ftp://ftp.ta.jcu.cz/pub/aa/${A}"
HOMEPAGE="http://www.ta.jcu.cz/aa/"

DEPEND=">=sys-libs/ncurses-5.1
	    slang? ( >=sys-libs/slang-1.4.2 )
	    X? ( >=x11-base/xfree-4.0.1 )"

RDEPEND=">=sys-libs/ncurses-5.1
	    slang? ( >=sys-libs/slang-1.4.2 )
	    X? ( >=x11-base/xfree-4.0.1 )"

src_unpack() {

    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-configure-gpm-gentoo.diff
    patch -p0 < ${FILESDIR}/${P}-configure.in-gpm-gentoo.diff
    touch *
}

src_compile() {

    local myconf
    if [ "`use slang`" ]
    then
      myconf="--with-slang-driver=yes"
    else
      myconf="--with-slang-driver=no"
    fi
    if [ "`use X`" ]
    then
      myconf="${myconf} --with-x11-driver=yes"
    else
      myconf="${myconf} --with-x11-driver=no"
    fi
    if [ -z "`use gpm`" ]
    then
      myconf="${myconf} --with-gpm-mouse=no"
    fi

    try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST} ${myconf}
    try make

}

src_install () {

    try make prefix=${D}/usr infodir=${D}/usr/share/info install

    dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*

}

