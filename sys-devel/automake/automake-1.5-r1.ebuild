# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.5-r1.ebuild,v 1.3 2002/04/27 23:34:20 bangert Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to generate Makefile.in from Makefile.am"
SRC_URI="ftp://prep.ai.mit.edu/gnu/automake/${A}"
HOMEPAGE="http://www.gnu.org/software/automake/automake.html"

DEPEND="sys-devel/perl"

SLOT="1.5"

src_compile() {
    try ./configure --prefix=/usr --infodir=/usr/share/info --host=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {
    try make prefix=${D}/usr infodir=${D}/usr/share/info install
    dodoc COPYING NEWS README THANKS TODO AUTHORS ChangeLog
}
