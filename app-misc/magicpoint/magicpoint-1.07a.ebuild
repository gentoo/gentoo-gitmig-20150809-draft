# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <aj@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/magicpoint/magicpoint-1.07a.ebuild,v 1.3 2001/06/17 12:51:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="an X11 based presentation tool"
SRC_URI="ftp://ftp.mew.org/pub/MagicPoint/${A}"
HOMEPAGE="http://www.mew.org/mgp/"

DEPEND="virtual/glibc virtual/x11
	ungif? ( >=media-libs/libungif-4.0.1 )
	gif?   ( >=media-libs/giflib-4.0.1 )"

src_compile() {
   
   export LIBS="-L/usr/lib/ -L/usr/X11R6/lib/ -lX11"
   if [ "`use gif`" ] && [ "`use ungif`" ] ; then
     GIF_FLAG="--enable-gif";
   else
     GIF_FLAG="--disable-gif";
   fi
   try ./configure --with-x $GIF_FLAG
   try xmkmf
   try make Makefiles
   try make clean
   try make ${MAKEOPTS}
}

src_install() {                               
    try make DESTDIR=${D} install
    try make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
             MANPATH=/usr/share/man MANSUFFIX=1 install.man

    dodoc COPYRIGHT* FAQ README* RELNOTES SYNTAX TODO* USAGE*
}


