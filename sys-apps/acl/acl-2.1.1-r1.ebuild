# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/acl/acl-2.1.1-r1.ebuild,v 1.5 2003/06/21 21:19:38 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="XFS dump/restore utilities"

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

KEYWORDS="x86 amd64 ~mips"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="sys-apps/attr"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	./configure \
	    --mandir=/usr/share/man \
	    --prefix=/usr \
	    --libexecdir=/usr/lib \
	    --libdir=/lib
	    
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
	-e 's:-O1::' include/builddefs.orig > include/builddefs || die
	    
	emake || die
	
}

src_install() {
	make DESTDIR=${D} install install-dev install-lib || die
	
	rm -f ${D}/usr/lib/libacl.so
	rm -f ${D}/lib/*a
	dosym /lib/libacl.so /usr/lib/libacl.so
	dosym /usr/lib/libacl.la /lib/libacl.la
	dosym /usr/lib/libacl.a /lib/libacl.a
}
