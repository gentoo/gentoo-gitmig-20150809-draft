# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1-r1.ebuild,v 1.1 2000/08/02 17:07:12 achim Exp $

P=findutils-4.1      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
CATEGORY="sys-apps"
SRC_URI="ftp://prep.ai.mit.edu/gnu/findutils/findutils-4.1.tar.gz"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

src_compile() {                           
    ./configure --prefix=/usr --host=${CHOST}
    make
}

src_unpack() {
    unpack ${A}
    einfo "Applying Patch..."
    #using sed to apply minor patches to files
    cd ${S}/find
    mv fstype.c fstype.c.orig
    sed -e "33d" -e "34d" fstype.c.orig > fstype.c
    mv parser.c parser.c.orig
    sed -e "55d" parser.c.orig > parser.c
    mv pred.c pred.c.orig
    sed -e '29i\' -e '#define FNM_CASEFOLD (1<<4)' pred.c.orig > pred.c
    cd ${S}/lib
    mv nextelem.c nextelem.c.orig
    sed -e "35d" nextelem.c.orig > nextelem.c
    cd ${S}/xargs
    mv xargs.c xargs.c.orig
    sed -e "63d" -e "64d" xargs.c.orig > xargs.c
}

src_install() {                               
    cd ${S}
    cd locate
    cp updatedb updatedb.orig
    sed -e 's:LOCATE_DB=/usr/var/locatedb:LOCATE_DB=/var/lib/locate/locatedb:' -e 's:TMPDIR=/usr/tmp:TMPDIR=/tmp:' updatedb.orig > updatedb   
    cd ..

    into /usr
    doinfo doc/find.info doc/find.info-1 doc/find.info-2
    dobin find/find locate/locate locate/updatedb xargs/xargs
    doman find/*.1 locate/*.1 locate/*.5 xargs/*.1
    exeinto /usr/libexec
    doexe locate/bigram locate/code locate/frcode
    dodoc COPYING NEWS README TODO ChangeLog
}

