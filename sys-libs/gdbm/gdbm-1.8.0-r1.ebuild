# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.0-r1.ebuild,v 1.6 2000/11/30 23:14:00 achim Exp $

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

DEPEND=">=sys-libs/glibc-2.1.3"

RDEPEND=$DEPEND

src_compile() {                           
    try ./configure --host=${CHOST} --prefix=/usr
    try pmake 
}

src_install() {      
    try make prefix=${D}/usr install                         
    dodoc COPYING ChangeLog NEWS README
}



