# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-5.3.ebuild,v 1.1 2004/07/17 09:05:24 robbat2 Exp $

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others"
HOMEPAGE="http://www.cgsecurity.org/index.html?testdisk.html"
SRC_URI="http://www.cgsecurity.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=sys-fs/ntfsprogs-1.9.0
	>=sys-fs/reiserfsprogs-3.6.13
	>=sys-fs/e2fsprogs-1.35"

src_compile() {
	econf || die
	emake || die
	mv src/testdisk src/testdisk.dynamic
	emake smallstatic || die
	mv src/testdisk src/testdisk.static
	cp src/testdisk.dynamic src/testdisk
}

src_install() {
	einstall || die
	dosbin src/testdisk.static
}

