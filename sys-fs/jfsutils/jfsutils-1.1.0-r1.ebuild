# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jfsutils/jfsutils-1.1.0-r1.ebuild,v 1.2 2004/04/10 01:20:53 kumba Exp $

S=${WORKDIR}/${P}

DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"

KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man --sbindir=/sbin || die
	emake || die
}

src_install () {
	make DESTDIR=$D install
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	cd ${D}/sbin
	rm -f mkfs.jfs; ln -sf jfs_mkfs mkfs.jfs
	rm -f fsck.jfs; ln -sf jfs_fsck fsck.jfs
}
