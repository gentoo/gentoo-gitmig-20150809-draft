# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/divx4linux/divx4linux-20010803.ebuild,v 1.1 2001/08/06 20:57:20 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="Binary version of a DivX4 decoder library for linux"
SRC_URI="http://avifile.sourceforge.net/${A}"
HOMEPAGE="http://avifile.sourceforge.net/"

src_install () {

    cd ${S}
    dolib.so *.so
    insinto /usr/include
    doins *.h
    mv "Codec Core Interface.txt" CodecCoreInterface.txt
    dodoc RELNOTES.linux *.txt

}

