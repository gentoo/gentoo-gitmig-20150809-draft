# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.4a-r4.ebuild,v 1.5 2002/07/16 05:51:11 seemant Exp $

S=${WORKDIR}/flex-2.5.4
DESCRIPTION="GNU lexical analyser generator"
SRC_URI="ftp://ftp.gnu.org/gnu/non-gnu/flex/flex-2.5.4a.tar.gz"
HOMEPAGE="http://www.gnu.org/software/flex/flex.html"
LICENSE="FLEX"
SLOT="0"
KEYWORDS="x86 ppc"

DEPEND="virtual/glibc"
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
        rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib
    fi
	cd ${D}/usr/bin
	ln -s flex lex
}


