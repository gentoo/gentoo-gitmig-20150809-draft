# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r3.ebuild,v 1.1 2001/02/27 15:41:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/flex-2.5.4
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/non-gnu/flex/${A}
	 ftp://prep.ai.mit.edu/non-gnu/flex/${A}"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"

DEPEN="virtual/glibc"
RDEPEND="virtual/glibc"


src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}

    if [ -z "`use static`" ]
    then
        try make ${MAKEOPTS}
    else
        try make ${MAKEOPTS} LDFLAGS=-static
    fi

}

src_install() {

    try make prefix=${D}/usr mandir=${D}/usr/share/man/man1 install
    if [ -z "`use build`" ]
    then
        dodoc COPYING NEWS README
    else
        rm -rf ${D}/usr/share/man ${D}/usr/include ${D}/usr/lib
    fi

}


