# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/coin/coin-20010215.ebuild,v 1.2 2001/06/04 00:16:12 achim Exp $


A=Coin-${PV}.tar.gz
S=${WORKDIR}/Coin
DESCRIPTION="An OpenSource implementation of SGI's OpenInventor"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${A}"
HOMEPAGE="http://www.coin3d.org"

DEPEND="virtual/x11 virtual/opengl virtual/glu"

src_compile() {

    local myconf
    if [ -z "`use X`" ]
    then
      myconf="--without-x"
    fi
    try ./configure --prefix=/usr/X11R6 --with-glu=/usr --host=${CHOST} $myconf
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 install
    dodoc AUTHORS COPYING ChangeLog* HACKING LICENSE* NEWS README*
    docinto txt
    dodoc docs/*.txt docs/coin.doxygen docs/whitepapers/*.txt

}

