# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.5.3.ebuild,v 1.1 2001/01/05 07:03:30 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="ftp://heroines.sourceforge.net/pub/heroines/${A}"
HOMEPAGE="http://heroines.sourceforge.net/"

DEPEND=">=sys-devel/gcc-2.95.2
	>=sys-libs/glibc-2.1.3
	>=dev-lang/nasm-0.98
	>=dev-libs/glib-1.2.8
	>=media-libs/libpng-1.0.7
	>=x11-base/xfree-4.0.1"

src_compile() {

    cd ${S}
    try ./configure
    try make

}

src_install () {

    cd ${S}
    into /usr/X11R6
    dobin xmovie/xmovie
    dodoc README
    docinto html
    dodoc docs/index.html

}



