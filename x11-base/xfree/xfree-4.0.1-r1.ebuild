# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.0.1-r1.ebuild,v 1.1 2000/08/12 16:26:10 achim Exp $

P=xfree-4.0.1
A="X401src-1.tgz X401src-2.tgz X401src-3.tgz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree - 4.0.1"
CATEGORY=x11-base
SRC_URI="ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-1.tgz
ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-2.tgz
ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-3.tgz"

src_unpack () {
  unpack ${A}
}

src_compile() {                         
    cd ${S}
    make World
}

src_install() {                               
    make install DESTDIR=${D}
    make install.man DESTDIR=${D}
    prepman /usr/X11R6
}



