# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/attr/attr-2.1.1-r1.ebuild,v 1.5 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="xfs extended attributes tools"

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

KEYWORDS="x86 amd64 ~mips"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="virtual/glibc"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	./configure \
	    --prefix=/usr \
	    --mandir=/usr/share/man \
	    --libdir=/lib \
	    --libexecdir=/usr/lib || die
	    
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' -e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs.orig > include/builddefs || die
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-lib install-dev || die
	
	dodir /lib
	dosym /usr/lib/libattr.a /lib/libattr.a
	dosym /usr/lib/libattr.la /lib/libattr.la
	dosym /lib/libattr.so /usr/lib/libattr.so
}
