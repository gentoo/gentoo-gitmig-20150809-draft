# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.0.2.ebuild,v 1.1 2000/12/21 02:10:13 achim Exp $

A="X402src-1.tgz X402src-2.tgz X402src-3.tgz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree - 4.0.2"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/4.0.2/source"
SRC_PATH1="ftp://download.sourceforge.net/pub/mirrors/XFree86/4.0.2/source"
SRC_URI="$SRC_PATH0/X402src-1.tgz $SRC_PATH0/X402src-2.tgz $SRC_PATH0/X402src-3.tgz
	 $SRC_PATH1/X402src-1.tgz $SRC_PATH1/X402src-2.tgz $SRC_PATH1/X402src-3.tgz"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"


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
    preplib /usr/X11R6
}




