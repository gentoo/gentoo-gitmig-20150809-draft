# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/jfsutils/jfsutils-1.1.0-r2.ebuild,v 1.4 2003/06/21 21:19:40 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"

KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	econf \
		--sbindir=/sbin 
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die	
	
	rm -f ${D}/sbin/mkfs.jfs fsck.jfs
	dosym /sbin/jfs_mkfs /sbin/mkfs.jfs
	dosym /sbin/jfs_fsck /sbin/fsck.jfs
	
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
}
