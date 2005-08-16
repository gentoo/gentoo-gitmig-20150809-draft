# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-5.7.ebuild,v 1.3 2005/08/16 19:30:09 blubb Exp $

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others. Also includes PhotoRec to recover pictures from digital camera memory."
HOMEPAGE="http://www.cgsecurity.org/index.html?testdisk.html"
SRC_URI="http://www.cgsecurity.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static reiserfs"
DEPEND=">=sys-libs/ncurses-5.2
	>=sys-fs/ntfsprogs-1.9.4
	reiserfs? ( >=sys-fs/progsreiserfs-0.3.1_rc8 )
	>=sys-fs/e2fsprogs-1.35"

src_compile() {
	econf || die
	if ! use reiserfs;
	then
		sed -i -e "s/.*REISERFS.*//g" config.h
		sed -i -e "s/\-lreiserfs//g"  Makefile src/Makefile
	fi
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

