# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/bin86/bin86-0.15.5.ebuild,v 1.5 2002/08/01 11:59:04 seemant Exp $

A=${P}.tar.gz
S=${WORKDIR}/bin86
DESCRIPTION="Assembler and loader used to create kernel bootsector"
SRC_URI="http://www.cix.co.uk/~mayday/${A}"
HOMEPAGE="http://www.cix.co.uk/~mayday/"
DEPEND="virtual/glibc"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

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


