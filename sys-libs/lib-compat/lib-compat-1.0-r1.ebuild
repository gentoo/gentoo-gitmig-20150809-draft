# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.0-r1.ebuild,v 1.4 2000/11/07 11:16:08 achim Exp $

P=lib-compat-1.0      
A=lib-compat.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Compatibility c++ and libc5 libraries for programs new and old"
SRC_URI="ftp://gentoolinux.sourceforge.net/pub/gentoolinux/current/distfiles/"${A}

DEPEND=""
RDEPEND=""

src_unpack () {
  mkdir ${S}
  cd ${S}
  unpack ${A}
}

src_compile() {                           
   echo
}

src_install() {                               
    into /usr
    dolib.so *.so* 
    preplib /usr
}



