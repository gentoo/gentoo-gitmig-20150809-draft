# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jfsutils/jfsutils-1.1.0-r1.ebuild,v 1.5 2005/04/01 17:22:46 agriffis Exp $

DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc amd64"
IUSE=""

DEPEND="virtual/libc"

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
