# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.2.ebuild,v 1.2 2001/08/11 04:45:10 drobbins Exp $

#P=
A=itcl${PV}.tar.gz
S=${WORKDIR}/itcl${PV}
DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
SRC_URI="http://dev.scriptics.com/ftp/itcl/${A}"
HOMEPAGE="http://dev.scriptics.com/ftp/itcl/"

DEPEND=">=dev-lang/tcl-tk-8.4.2"

src_unpack() {
    unpack ${A}
    cd ${S}
    try patch -p1 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
    try ./configure --prefix=/usr --host=${CHOST}
    try make CFLAGS_DEFAULT="${CFLAGS}"
}

src_install () {
    try make prefix=${D}/usr install
    rm ${D}/usr/lib/iwidgets
    ln -s iwidgets3.0.1 ${D}/usr/lib/iwidgets
    dodoc CHANGES INCOMPATIBLE README TODO
    cd ${S}/doc ; docinto doc
    dodoc README
}

