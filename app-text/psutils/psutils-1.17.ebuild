# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-text/psutils/psutils-1.17.ebuild,v 1.2 2001/05/28 05:24:13 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${PN}
DESCRIPTION="Post Script Utilities"
SRC_URI="ftp://ftp.enst.fr/pub/unix/a2ps/${A}"
HOMEPAGE="http://"

DEPEND="virtual/glibc sys-devel/perl"
RDEPEND="virtual/glibc"

src_unpack() {
    unpack ${A}
    sed -e "s:/usr/local:\$(DESTDIR)/usr:" \
	-e "s:-DUNIX -O:-DUNIX ${CFLAGS}:" ${S}/Makefile.unix > ${S}/Makefile
}

src_compile() {

    try make

}

src_install () {
    dodir /usr/{bin,share/man}
    try make DESTDIR=${D} install
    dodoc README LICENSE
}

