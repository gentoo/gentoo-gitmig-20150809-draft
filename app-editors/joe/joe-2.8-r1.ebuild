# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-editors/joe/joe-2.8-r1.ebuild,v 1.9 2000/11/01 04:44:11 achim Exp $

P=joe-2.8      
A=joe2.8.tar.Z
S=${WORKDIR}/joe
DESCRIPTION="A free ASCII-Text Screen Editor for UNIX"
SRC_URI="ftp://ftp.std.com/src/editors/${A}
	 ftp://ftp.visi.com/disk3/unix/editors/${A}"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.1"

src_compile() {                           

    try make
    try make termidx
}

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${O}/files/joe2.8.dif
    cp Makefile Makefile.orig
    sed -e "s/-O2/${CFLAGS}/" Makefile.orig > Makefile
}

src_install() {                              
    into /usr
    dobin joe
    doman joe.1

    for i in jmacs jstar jpico rjoe
    do
      dosym /usr/bin/joe /usr/bin/$i
      dosym /usr/man/man1/joe.1.gz /usr/man/man1/$i.1.gz
    done

    dobin termidx
    dolib joerc
    dolib jmacsrc
    dolib jstarrc
    dolib rjoerc
    dolib jpicorc

#    insinto /etc
#    doins termcap
    dodoc copying INFO LIST README TODO VERSION
}





