# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-2.9.5.ebuild,v 1.1 2001/03/30 02:13:52 achim Exp $

A=${P}.tgz
S=${WORKDIR}/${P}
DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
SRC_URI="http://ftp1.sourceforge.net/joe-editor/${A}"
HOMEPAGE="http://sourceforge.net/projects/joe-editor/"

DEPEND=">=sys-libs/ncurses-5.2-r2"



src_unpack() {

    unpack ${A}
    cd ${S}
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile

}

src_compile() {                           

    try make joe termidx
}

src_install() {                              
    into /usr
    dobin joe
    doman joe.1
    dolib joerc
    for i in jmacs jstar jpico rjoe
    do
      dosym joe /usr/bin/$i
      dosym joe.1.gz /usr/share/man/man1/$i.1.gz
      dolib ${i}rc
    done

    dodoc copying INFO LIST README TODO VERSION
}





