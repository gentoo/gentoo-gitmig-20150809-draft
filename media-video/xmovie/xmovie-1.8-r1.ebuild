# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.8-r1.ebuild,v 1.3 2002/07/11 06:30:42 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="http://heroinewarrior.com/${A}"
HOMEPAGE="http://heroines.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11 >=sys-devel/gcc-2.95.2
	>=dev-lang/nasm-0.98
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.0.7"

RDEPEND="virtual/glibc virtual/x11 >=sys-devel/gcc-2.95.2
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.0.7"

src_compile() {
    if [ "`use mmx`" ] ; then
      try ./configure
    else
      try ./configure --no-mmx
    fi
    try make

}

src_install () {

    into /usr
    dobin xmovie/`uname -m`/xmovie
    dodoc README
    docinto html
    dodoc docs/index.html

}



