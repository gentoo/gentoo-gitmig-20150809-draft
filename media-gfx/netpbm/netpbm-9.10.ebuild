# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Peter Gavin <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/netpbm/netpbm-9.10.ebuild,v 1.1 2001/02/21 06:39:05 pete Exp $

#P=
A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="a set of utilities for converting to/from the netpbm (and related) formats"
SRC_URI="http://download.sourceforge.net/netpbm/${A}"
HOMEPAGE="http://netpbm.sourceforge.net/"

DEPEND=""

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
}
