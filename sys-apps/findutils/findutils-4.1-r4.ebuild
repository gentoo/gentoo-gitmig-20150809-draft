# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/findutils/findutils-4.1-r4.ebuild,v 1.1 2001/02/07 15:51:27 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNU utilities to find files"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/findutils/${A}
	 ftp://prep.ai.mit.edu/gnu/findutils/${A}"
HOMEPAGE="http://www.gnu.org/software/findutils/findutils.html"

DEPEND="virtual/glibc"

src_unpack() {

    unpack ${A}
    echo "Applying Patch..."
    #using sed to apply minor patches to files
    cd ${S}

    cd find
    cp fstype.c fstype.c.orig
    sed -e "33d" -e "34d" fstype.c.orig > fstype.c
    cp parser.c parser.c.orig
    sed -e "55d" parser.c.orig > parser.c
    cp pred.c pred.c.orig
    sed -e '29i\' -e '#define FNM_CASEFOLD (1<<4)' pred.c.orig > pred.c
    cd ${S}/lib
    cp nextelem.c nextelem.c.orig
    sed -e "35d" nextelem.c.orig > nextelem.c
    cd ${S}/xargs
    cp xargs.c xargs.c.orig
    sed -e "63d" -e "64d" xargs.c.orig > xargs.c
}

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr

    # do not use pmake recursive
    try make LOCATE_DB=/var/lib/misc/locatedb  \
	libexecdir=/usr/lib/find $MAKEOPTS
}

src_install() {

    try make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info libexecdir=${D}/usr/lib/find \
	LOCATE_DB=${D}/var/lib/misc/locatedb install
    dosed "s:TMPDIR=/usr/tmp:TMPDIR=/tmp:" usr/bin/updatedb
    
    rm -fr ${D}/usr/var
    dodoc COPYING NEWS README TODO ChangeLog

}

