# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf/autoconf-2.50c.ebuild,v 1.1 2001/08/08 20:37:43 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Used to create autoconfiguration files"
SRC_URI="ftp://alpha.gnu.org/gnu/${PN}/${A}"
HOMEPAGE="http://www.gnu.org/software/autoconf/autoconf.html"

DEPEND=">=sys-devel/m4-1.4o-r2"

src_unpack() {
    unpack ${A}
    cd ${S}
}

src_compile() {
    try ./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --target=${CHOST}
    try make ${MAKEOPTS}
}

src_install() {
    try make prefix=${D}/usr infodir=${D}/usr/share/info install
    dodoc COPYING AUTHORS BUGS ChangeLog ChangeLog.0 ChangeLog.1 NEWS README TODO THANKS
}


