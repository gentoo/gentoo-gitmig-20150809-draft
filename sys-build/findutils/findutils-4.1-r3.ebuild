# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-build/findutils/findutils-4.1-r3.ebuild,v 1.1 2001/01/27 09:47:20 achim Exp $

P=findutils-4.1      
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/findutils/${A}
	 ftp://prep.ai.mit.edu/gnu/findutils/${A}"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

DEPEND=">=sys-libs/glibc-2.1.3"
RDEPEND="$DEPEND
	 >=sys-apps/bash-2.04"

src_compile() {                           
    try ./configure --prefix=/usr --host=${CHOST}
    # do not use pmake recursive
    try make LOCATE_DB=/var/lib/locatedb  \
	libexecdir=/usr/lib/find $MAKEOPTS LDFLAGS=-static
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
    try make prefix=${D}/usr libexecdir=${D}/usr/lib/find \
	LOCATE_DB=${D}/var/lib/locatedb install
    dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
    rm -fr ${D}/usr/var ${D}/usr/man ${D}/usr/info
}

