# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/dgs/dgs-0.5.10.ebuild,v 1.1 2000/11/26 20:54:17 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Ghostscript based DPS server"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dgs/${A}"
HOMEPAGE="http://www.aist-nara.ac.jp/~masata-y/dgs/index.html"

DEPEND=">=sys-apps/bash-2.04
	>=sys-libs/glibc-2.1.3
	>=dev-libs/glib-1.2.8
	>=x11-base/xfree-4.0.1"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} --with-x
    try make

}

src_install () {

    cd ${S}
    make prefix=${D}/usr install
  
    dodoc ANNOUNCE ChangeLog FAQ NEWS NOTES README STATUS TODO Version
}

