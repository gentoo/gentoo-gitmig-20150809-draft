# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/mpeg2vidcodec/mpeg2vidcodec-12.ebuild,v 1.2 2000/11/01 04:44:18 achim Exp $

P=mpeg2vidcodec_v12
A=${P}.tar.gz
S=${WORKDIR}/mpeg2
DESCRIPTION="MPEG Library"
SRC_URI="ftp://ftp.mpeg.org/pub/mpeg/mssg/${A}"
HOMEPAGE="http://www.mpeg.org"

DEPEND=">=sys-libs/glibc-2.1.3"

src_unpack () {

  unpack ${A}
  cd ${S}
  cp Makefile Makefile.orig
  sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile

}
src_compile() {

    cd ${S}
    try make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin src/mpeg2dec/mpeg2decode
    dobin src/mpeg2enc/mpeg2encode
    dodoc README doc/*

}

