# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.15.4-r1.ebuild,v 1.2 2001/02/27 12:34:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/bin86
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${A}"
HOMEPAGE="http://www.cix.co.uk/~mayday/"
DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/bin86-0.15.4-Makefile-gentoo.diff
}

src_compile() {

	try make ${MAKEOPTS}

}

src_install() {

    try make DESTDIR=${D} install

    dodoc README README-0.4 ChangeLog 
    docinto as
    dodoc as/COPYING as/TODO
}


