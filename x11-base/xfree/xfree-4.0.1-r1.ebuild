# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.0.1-r1.ebuild,v 1.5 2000/10/23 11:27:17 achim Exp $

P=xfree-4.0.1
A="X401src-1.tgz X401src-2.tgz X401src-3.tgz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree - 4.0.1"
SRC_URI="ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-1.tgz
ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-2.tgz
ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-3.tgz"

src_unpack () {
  unpack ${A}
  cp ${FILESDIR}/site.def ${S}/config/cf/host.def
}

src_compile() {                         
    cd ${S}
    try make World
}

src_install() {                               
    try make install DESTDIR=${D}
    try make install.man DESTDIR=${D}
}



