# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/jfsutils/jfsutils-1.0.17.ebuild,v 1.4 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr \
		--sbindir=/sbin \
		--host=${CHOST} \
		--sysconfdir=/etc \
		--mandir=/usr/share/man || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	
	if use bootcd ;
	then
		rm -rf ${D}/usr
	fi
}

