# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.7.ebuild,v 1.3 2001/06/03 09:54:22 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="http://heroinewarrior.com/${A}"
HOMEPAGE="http://heroines.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11 >=sys-devel/gcc-2.95.2
	>=dev-lang/nasm-0.98
	>=dev-libs/glib-1.2.8
	>=media-libs/libpng-1.0.7"

RDEPEND="virtual/glibc virtual/x11 >=sys-devel/gcc-2.95.2
	>=dev-libs/glib-1.2.8
	>=media-libs/libpng-1.0.7"

src_compile() {

    try ./configure
    try make

}

src_install () {

    into /usr/X11R6
    dobin xmovie/`uname -m`/xmovie
    dodoc README
    docinto html
    dodoc docs/index.html

}



