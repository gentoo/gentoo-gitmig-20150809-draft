# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Taras Glek <taras.glek@home.com>
# /home/cvsroot/gentoo-x86/net-www/amaya/amaya-4.1-r1.ebuild,v 1.1 2001/10/06 11:33:58 verwilst Exp

S=${WORKDIR}/$PN/gtk
MY_PV=141
DESCRIPTION="A very powerfull editor for programmers"
SRC_URI="http://www.scintilla.org/${PN}${MY_PV}.tgz" 
HOMEPAGE="http://www.scintilla.org"

DEPEND=">=x11-libs/gtk+-1.2.10-r4"
RDEPEND=">=x11-libs/gtk+-1.2.10-r4"

src_compile() {

    try make -C ../../scintilla/gtk
    try sed 's/usr\/local/usr/g' makefile > Makefile.good 
    rm makefile
    mv Makefile.good makefile # could just use perl -pi -e, but perl might not be installed or something
    try make
}

src_install () {

    dodir /usr
    dodir /usr/bin
    dodir /usr/share
    try make prefix=${D}/usr install
    mv ${D}/usr/bin/SciTE ${D}/usr/bin/scite
}

