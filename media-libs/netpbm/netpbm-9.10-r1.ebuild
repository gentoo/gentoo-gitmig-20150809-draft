# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-9.10-r1.ebuild,v 1.1 2001/02/22 16:44:19 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="The Net PBM library"
SRC_URI="http://download.sourceforge.net/netpbm/${A}"
HOMEPAGE="http://netpbm.sourceforge.net"

DEPEND=">=media-libs/libpng-1.0.9
        >=media-libs/tiff-3.5.5"

RDEPEND=">=media-libs/libpng-1.0.9
        >=media-libs/jpeg-6b"

src_unpack() {
  unpack ${A}
  cp ${FILESDIR}/Makefile.config ${S}
}

src_compile() {

    try make CFLAGS=\"${CFLAGS}\"

}

src_install () {

    dodir /usr/lib/netpbm
    try make PREFIX=${D}/usr CFLAGS=\"${CFLAGS}\" install

    dodoc COPYRIGHT.PATENT GPL_LICENSE.txt HISTORY
    dodoc Netpbm.programming README*
}

