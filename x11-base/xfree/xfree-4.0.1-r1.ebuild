# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.0.1-r1.ebuild,v 1.7 2000/12/21 08:22:29 achim Exp $

P=xfree-4.0.1
A="X401src-1.tgz X401src-2.tgz X401src-3.tgz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree - 4.0.1"
SRC_URI="ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-1.tgz
ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-2.tgz
ftp://ftp.xfree.org/pub/XFree86/4.0.1/source/X401src-3.tgz"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"


src_unpack () {
  unpack ${A}
  cp ${FILESDIR}/${PV}/site.def ${S}/config/cf/host.def
}

src_compile() {                         
    cd ${S}
    try make World
}

src_install() {                               
    try make install DESTDIR=${D}
    try make install.man DESTDIR=${D}
    preplib /usr/X11R6
}




