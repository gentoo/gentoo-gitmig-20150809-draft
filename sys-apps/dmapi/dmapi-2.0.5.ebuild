# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dmapi/dmapi-2.0.5.ebuild,v 1.9 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="XFS data management API library"

SRC_URI="ftp://oss.sgi.com/projects/xfs/download/cmd_tars/${P}.src.tar.gz"
HOMEPAGE="http://oss.sgi.com/projects/xfs"

KEYWORDS="x86 amd64"
SLOT="0"
LICENSE="LGPL-2.1"

DEPEND="sys-apps/xfsprogs"

src_compile() {
	OPTIMIZER="${CFLAGS}"
	DEBUG=-DNDEBUG
	
	autoconf || die
	
	./configure --prefix=/usr \
		    --libexecdir=/lib || die
	
	cp include/builddefs include/builddefs.orig
	sed -e 's:^PKG_\(.*\)_DIR = \(.*\)$:PKG_\1_DIR = ${DESTDIR}\2:' \
		-e "s:/usr/share/doc/${PN}:/usr/share/doc/${PF}:" \
		-e 's:-O1::' \
		-e 's:../$(INSTALL) -S \(.*\) $(PKG_.*_DIR)/\(.*$\)::' \
		include/builddefs.orig > include/builddefs || die
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install install-dev || die

	dosym /lib/libdm.a /usr/lib/libdm.a
	dosym /lib/libdm.la /usr/lib/libdm.la
	dosym /usr/lib/libdm.so /lib/libdm.so
}
