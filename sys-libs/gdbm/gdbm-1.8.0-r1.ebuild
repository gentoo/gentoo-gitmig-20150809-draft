# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.0-r1.ebuild,v 1.4 2000/10/03 16:02:07 achim Exp $

# FOR SOME REASON, THE CONFIGURE SCRIPT DOES NOT USE THE EXPORTED CFLAGS, SO
# THIS LIBRARY ONLY HAS -O OPTS, WE WON'T WORRY ABOUT THIS FOR SUCH AN 
# INSIGNIFICANT LIB, but one day...

P=gdbm-1.8.0  
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gdbm/${A}
	 ftp://prep.ai.mit.edu/gnu/gdbm/${A}"
HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try make
}

src_install() {                               
    into /usr
    dolib.a libgdbm.la .libs/libgdbm.a
    dolib.so .libs/libgdbm.so.2.0.0
    dosym libgdbm.so.2.0.0 /usr/lib/libgdbm.so.2
    dosym libgdbm.so.2.0.0 /usr/lib/libgdbm.so
    insinto /usr/include
    doins gdbm.h
    doman gdbm.3
    doinfo gdbm.info
    dodoc COPYING ChangeLog NEWS README
}



