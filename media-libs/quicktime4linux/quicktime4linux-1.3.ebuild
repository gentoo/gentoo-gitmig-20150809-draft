# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-libs/quicktime4linux/quicktime4linux-1.3.ebuild,v 1.3 2001/07/01 15:38:53 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="quicktime library for linux"
SRC_URI="http://heroinewarrior.com/${A}"
HOMEPAGE="http://heroinewarrior.com/quicktime.php3"

DEPEND="virtual/glibc media-libs/jpeg"
RDEPEND="virtual/glibc"

src_compile() {
    if [ -z "`use mmx`" ] ; then
      myconf="--no-mmx"
    fi
    try ./configure $myconf
#    echo "$CFLAGS" > c_flags
    try make

}

src_install () {

   dolib.so libquicktime.so
   dolib.a  libquicktime.a
   insinto /usr/include/quicktime
   doins *.h
   dodoc README 
   docinto html
   dodoc docs/*.html
}

