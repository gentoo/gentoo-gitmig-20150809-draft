# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.3.ebuild,v 1.1 2001/11/08 15:37:29 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An mpeg library for linux"
SRC_URI="http://heroinewarrior.com/${A}"
HOMEPAGE="http://heroinewarrior.com/libmpeg3.php3"

RDEPEND="virtual/glibc sys-libs/zlib media-libs/jpeg"
DEPEND="$RDEPEND dev-lang/nasm"

src_compile() {
    if [ -z "`use mmx`" ] ; then
      try ./configure --no-mmx
    else
      try ./configure 
    fi
    try make
}

src_install () {

   dolib.a ${CHOST%%-*}/libmpeg3.a
   insinto /usr/include/libmpeg3
   doins *.{h,inc}
   insinto /usr/include/libmpeg3/audio
   doins audio/*.h
   insinto /usr/include/libmpeg3/video
   doins video/*.h

   dodoc README
   docinto html
   dodoc docs/*.html
}

