# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5.1h-r1.ebuild,v 1.5 2000/11/30 23:14:33 achim Exp $

P=man-1.5h1 
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard commands to read man pages"
SRC_URI="ftp://ftp.win.tue.nl/pub/linux-local/utils/man/${A}"
DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_compile() {                           
    try ./configure +sgid +fsstnd +lang all
    for FOOF in src man2html
    do
	try pmake ${FOOF}/Makefile MANCONFIG=/etc/man.conf
	cd ${S}/${FOOF}
	cp Makefile Makefile.orig
	sed -e "s/gcc -O/gcc ${CFLAGS}/" Makefile.orig > Makefile
	cd ${S}
    done
    try make
}

src_unpacks() {
    unpack ${A}
    cd ${S}
    cp configure configure.orig
    sed -e 's!/bin:/usr/bin:/usr/ucb:/usr/local/bin:$PATH!/bin /usr/bin /usr/ucb /usr/local/bin $PATH!' configure.orig > configure
}

src_install() {                               
    cd ${S}/src
    into /usr
    dodir /usr/bin
    exeopts -s -m 2555 -o root -g man
    exeinto /usr/bin
    doexe man
    #chmod +x apropos whatis try makewhatis
    dobin apropos whatis
    dosbin try makewhatis
    insinto /etc
    doins man.conf
    cd ${S}/man2html
    dobin man2html
    doman man2html.1
    dodir /usr/man
    cd ${S}/man
    cp Makefile Makefile.orig
    echo "BINROOTDIR=${D}" > Makefile
    cat Makefile.orig >> Makefile
    try make installsubdirs
    cd ${S}
    dodoc COPYING LSM README* TODO

}


