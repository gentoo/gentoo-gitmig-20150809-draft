# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmpeg3/libmpeg3-1.2.3.ebuild,v 1.3 2001/06/23 21:34:37 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="An mpeg library for linux"
SRC_URI="http://www.directfb.org/download/contrib/${A}"
HOMEPAGE="http://"

RDEPEND="virtual/glibc sys-libs/zlib media-libs/jpeg"
DEPEND="$RDEPEND dev-lang/nasm"

src_compile() {
    if [ -z "`use mmx`" ] ; then
      try ./configure --no-css --no-mmx
    else
      try ./configure --no-css
    fi
    try make
}

src_install () {

   dolib.a libmpeg3.a
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

