# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfs-utils/reiserfs-utils-3.6.25.ebuild,v 1.1 2001/01/19 00:59:12 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="ftp://ftp.namesys.com/pub/reiserfsprogs/${A}"
HOMEPAGE="http://"

src_unpack() {
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
    dodir /sbin
    dodir /usr/man/man8
    try make SBIN=${D}sbin MANDIR=${D}usr/man/man8 install
    dodoc README


}

