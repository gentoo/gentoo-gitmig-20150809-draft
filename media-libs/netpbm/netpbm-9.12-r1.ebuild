# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <pete@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/netpbm/netpbm-9.12-r1.ebuild,v 1.2 2001/11/06 13:30:22 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="a set of utilities for converting to/from the netpbm (and related) formats"
SRC_URI="http://download.sourceforge.net/netpbm/${A}"
HOMEPAGE="http://netpbm.sourceforge.net/"

DEPEND=">=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.5"

src_unpack() {
    unpack ${A}
    cd ${S}
    cp ${FILESDIR}/${PV}/Makefile.config .
}

src_compile() {
    try make CFLAGS="${CFLAGS}"
}

src_install () {
    try make INSTALL_PREFIX="${D}/usr/" install
    insinto /usr/include/pbm
    doins pnm/{pam,pnm}.h ppm/{ppm,pgm,pbm}.h
    doins pbmplus.h shopt/shopt.h
    dodoc COPYRIGHT.PATENT GPL_LICENSE.txt HISTORY \
          Netpbm.programming README README.CONFOCAL README.DJGPP \
          README.JPEG README.VMS netpbm.lsm
}
