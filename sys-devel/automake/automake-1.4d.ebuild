# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.4d.ebuild,v 1.1 2001/02/18 01:29:18 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI=" ftp://sourceware.cygnus.com/pub/automake/${A}"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"

DEPEND="sys-devel/perl"

src_compile() {

    try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {

    try make prefix=${D}/usr infodir=${D}/usr/share/info install
    dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog

}


