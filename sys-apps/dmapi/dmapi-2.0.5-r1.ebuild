# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.0.5-r1.ebuild,v 1.4 2003/02/24 22:34:59 dragon Exp $

S=${WORKDIR}/${P}

DESCRIPTION="XFS data management API library"

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

KEYWORDS="x86 ~mips"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="sys-apps/xfsprogs"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	./configure \
	    --prefix=/usr \
	    --libdir=/lib \
	    --mandir=/usr/share/man \
	    --libexecdir=/usr/lib || die
	
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e 's:-O1::' -e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs.orig > include/builddefs || die
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-dev || die

	dodir /lib
	dosym /usr/lib/libdm.a /lib/libdm.a
	dosym /usr/lib/libdm.la /lib/libdm.la
	dosym /lib/libdm.so /usr/lib/libdm.so
}
