# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5.1h-r2.ebuild,v 1.2 2001/04/06 20:16:32 achim Exp $

P=man-1.5h1 
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard commands to read man pages"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/utils/man/${A}"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc
        sys-apps/groff"

src_unpacks() {
    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e 's!/bin:/usr/bin:/usr/ucb:/usr/local/bin:$PATH!/bin /usr/bin /usr/ucb /usr/local/bin $PATH!' configure.orig > configure
}

src_compile() {

    try ./configure +sgid +fsstnd +lang all
    for FOOF in src man2html
    do
	try pmake ${FOOF}/Makefile MANCONFIG=/usr/share/misc/man.conf
	cd ${S}/${FOOF}
	cp Makefile Makefile.orig
	sed -e "s/gcc -O/gcc ${CFLAGS}/" Makefile.orig > Makefile
	cd ${S}
    done
    try make

}


src_install() {

    cd src

    exeopts -s -m 2555 -o root -g man
    exeinto /usr/bin
    doexe man

    dobin apropos whatis
    dosbin makewhatis

    insinto /usr/share/misc

    doins ${FILESDIR}/man.conf

    cd ${S}/man2html
    dobin man2html
    doman man2html.1

    cd ${S}/man
    echo "BINROOTDIR=${D}" > Makefile.orig
    cat Makefile >> Makefile.orig
    sed -e "s:usr/man:usr/share/man:" Makefile.orig > Makefile
    try make installsubdirs 

    cd ${S}
    dodoc COPYING LSM README* TODO

}


