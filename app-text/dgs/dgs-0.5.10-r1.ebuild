# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-0.5.10-r1.ebuild,v 1.3 2001/05/01 18:29:05 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Ghostscript based DPS server"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dgs/${A}"
HOMEPAGE="http://www.aist-nara.ac.jp/~masata-y/dgs/index.html"

DEPEND="virtual/glibc	
	>=dev-libs/glib-1.2.8
	virtual/x11"

src_unpack() {
  unpack ${A}
  cd ${S}
  patch -p0 < ${FILESDIR}/${P}-gs-time_.h-gentoo.diff
}

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} --with-x
    try make

}

src_install () {

    make prefix=${D}/usr mandir=${D}/usr/share/man install
  
    dodoc ANNOUNCE ChangeLog FAQ NEWS NOTES README STATUS TODO Version
}

