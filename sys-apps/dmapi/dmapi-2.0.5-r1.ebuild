# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.0.5-r1.ebuild,v 1.14 2004/02/26 20:31:06 agriffis Exp $

DESCRIPTION="XFS data management API library"
HOMEPAGE="http://oss.sgi.com/projects/xfs/"
SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips ia64 amd64 alpha"

DEPEND="sys-fs/xfsprogs"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's:^PKG_\(.*\)_DIR[[:space:]]*= \(.*\)$:PKG_\1_DIR = $(DESTDIR)\2:' \
		-e 's:-O1::' \
		-e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs.in || die
}

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG

	autoconf || die

	./configure \
	    --prefix=/usr \
	    --libdir=/lib \
	    --mandir=/usr/share/man \
	    --libexecdir=/usr/lib || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install install-dev || die

	dodir /lib
	dosym /usr/lib/libdm.a /lib/libdm.a
	dosym /usr/lib/libdm.la /lib/libdm.la
	dosym /lib/libdm.so /usr/lib/libdm.so
}
