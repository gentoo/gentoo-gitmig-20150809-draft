# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/patch/patch-2.5.4-r3.ebuild,v 1.1 2001/02/27 18:16:03 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utility to apply diffs to files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/patch/${A}
	 ftp://ftp.gnu.org/gnu/patch/${A}"
HOMEPAGE="http://www.gnu.org/software/patch/patch.html"
DEPEND="virtual/glibc"

src_compile() {

	try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man
    if [ -z "`use static`" ]
    then
	    try make ${MAKEOPTS}
    else
        try make ${MAKEOPTS} LDFLAGS=-static
    fi

}

src_install() {

	try make prefix=${D}/usr mandir=${D}/usr/share/man install
    if [ -z "`use build`" ]
    then
	    dodoc AUTHORS COPYING ChangeLog NEWS README
    else
        rm -rf ${D}/usr/share/man
    fi

}



