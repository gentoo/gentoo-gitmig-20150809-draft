# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/coin/coin-20010215.ebuild,v 1.1 2001/04/29 15:08:26 achim Exp $


A=Coin-${PV}.tar.gz
S=${WORKDIR}/Coin
DESCRIPTION="An OpenSource implementation of SGI's OpenInventor"
SRC_URI="ftp://ftp.coin3d.org/pub/snapshots/${A}"
HOMEPAGE="http://www.coinn3d.org"

DEPEND="virtual/x11
		virtual/opengl"

src_compile() {

    local myconf
    if [ -z "`use X`" ]
    then
      myconf="--without-x"
    fi
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} $myconf
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 install
    dodoc AUTHORS COPYING ChangeLog* HACKING LICENSE* NEWS README*
    docinto txt
    dodoc docs/*.txt docs/coin.doxygen docs/whitepapers/*.txt

}

