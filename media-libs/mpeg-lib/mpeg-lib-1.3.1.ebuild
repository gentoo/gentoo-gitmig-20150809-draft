# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/mpeg-lib/mpeg-lib-1.3.1.ebuild,v 1.1 2000/10/18 06:07:54 achim Exp $

P=mpeg_lib-${PV}
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A lib for MPEG-1 video"
SRC_URI="ftp://ftp.mni.mcgill.ca/pub/mpeg/${A}"
HOMEPAGE="http://"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --disable-dither
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr install
    dodoc CHANGES README doc/image_format.eps doc/mpeg_lib.* 
}

