# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
#        Chad Huneycutt <chad.huneycutt@acm.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gdbm/gdbm-1.8.0-r3.ebuild,v 1.4 2001/11/24 18:40:50 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU database libraries included for compatibility with Perl"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gdbm/${P}.tar.gz"

HOMEPAGE="http://www.gnu.org/software/gdbm/gdbm.html"

DEPEND="virtual/glibc
        berkdb? ( =sys-libs/db-1.85-r1 )"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    try ./configure --host=${CHOST} --prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info
    try make CFLAGS="${CFLAGS} -fomit-frame-pointer" ${MAKEOPTS}
}

src_install() {

    try make prefix=${D}/usr man3dir=${D}/usr/share/man/man3 \
	    infodir=${D}/usr/share/info install
	
    dodoc COPYING ChangeLog NEWS README

}
