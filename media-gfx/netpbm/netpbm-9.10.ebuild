# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/netpbm/netpbm-9.10.ebuild,v 1.3 2001/02/21 08:25:18 pete Exp $

#P=
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
    patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    try make CFLAGS=\""${CFLAGS}"\"
}

src_install () {
    try make INSTALL_PREFIX=\""${D}/usr/"\" install
    dodoc COPYRIGHT.PATENT GPL_LICENSE.txt HISTORY
    dodoc Netpbm.programming README README.CONFOCAL README.DJGPP
    dodoc README.JPEG README.VMS netpbm.lsm
}
