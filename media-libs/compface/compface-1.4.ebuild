# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael C Tisltra <tadpol@tadpol.org>
# $header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Utilities and library to convert to/from X-Face format"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/graphics/convert/${A}"
HOMEPAGE=""

DEPEND="virtual/glibc"

src_compile() {
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {
    dodir /usr/share/man/man{1,3} /usr/{bin,include,lib}
    try make prefix=${D}/usr MANDIR=${D}/usr/share/man install
    dodoc README ChangeLog
}

