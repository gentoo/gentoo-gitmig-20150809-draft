# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.15.4.ebuild,v 1.3 2001/01/31 20:49:07 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/bin86
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${A}"
HOMEPAGE="http://www.cix.co.uk/~mayday/"
DEPEND="virtual/glibc"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_compile() {                           
	try make ${MAKEOPTS}
}

src_unpack() {
    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/CFLAGS=-O2/CFLAGS=${CFLAGS}/" \
	-e "s:INSTALL_OPTS=-m 755 -s:INSTALL_OPTS=-m 755:" \
	Makefile.orig > Makefile
}

src_install() { 
    dodir /usr/bin
    dodir /usr/man/man1
    try make PREFIX=${D}/usr install 
    dodoc README README-0.4 ChangeLog 
    docinto as
    dodoc as/COPYING as/TODO
}


