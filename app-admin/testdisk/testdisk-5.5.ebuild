# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-5.5.ebuild,v 1.1 2005/01/26 04:28:01 dragonheart Exp $

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others"
HOMEPAGE="http://www.cgsecurity.org/index.html?testdisk.html"
SRC_URI="http://www.cgsecurity.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="static"
DEPEND=">=sys-libs/ncurses-5.2
	>=sys-fs/ntfsprogs-1.9.0
	>=sys-fs/reiserfsprogs-3.6.13
	>=sys-fs/e2fsprogs-1.35"

src_compile() {
	econf || die
	if use static;
	then
		emake smallstatic || die
	else
		emake || die
	fi
}

src_install() {
	emake DESTDIR=${D} install || die
}

