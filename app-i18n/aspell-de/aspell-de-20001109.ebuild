# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/app-i18n/aspell-de/aspell-de-20001109.ebuild,v 1.3 2001/05/28 14:32:32 achim Exp $

P=igerman98-${PV}
S=${WORKDIR}/${P}
DESCRIPTION="A german dictionary for ispell"
SRC_URI="http://www.suse.de/~bjacke/igerman98/dict/${P}.tar.bz2"
HOMEPAGE="http://www.suse.de/~bjacke/igerman98/"

DEPEND="app-text/aspell app-text/ispell"
RDEPEND="app-text/aspell"

src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s:^ASPELL.*:ASPELL = aspell --data-dir=./aspell:" \
	Makefile.orig > Makefile
    ln -s /usr/share/aspell/iso8859-1.dat aspell
}

src_compile() {

    try make aspell

}

src_install () {

    dodir /usr/share/pspell
    echo "/usr/lib/aspell/german" > ${D}/usr/share/pspell/de-aspell.pwli

    insinto /usr/share/aspell
    doins aspell/german*.dat
    insinto /usr/lib/aspell
    doins german
 
    dodoc Documentation/*

}

