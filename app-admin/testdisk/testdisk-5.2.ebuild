# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-5.2.ebuild,v 1.7 2005/11/07 11:57:01 dragonheart Exp $

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others. Also includes PhotoRec to recover pictures from digital camera memory."
HOMEPAGE="http://www.cgsecurity.org/index.html?testdisk.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""
DEPEND=">=sys-fs/ntfsprogs-1.9.0
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

