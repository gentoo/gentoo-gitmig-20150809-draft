# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-5.9.ebuild,v 1.2 2005/11/07 12:17:02 dragonheart Exp $


MY_P=${P}-WIP

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others. Also includes PhotoRec to recover pictures from digital camera memory."
HOMEPAGE="http://www.cgsecurity.org/index.html?testdisk.html"
SRC_URI="http://www.cgsecurity.org/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="static reiserfs ntfs"
DEPEND=">=sys-libs/ncurses-5.2
	ntfs? ( >=sys-fs/ntfsprogs-1.9.4 )
	reiserfs? ( sys-fs/reiserfsprogs )
	>=sys-fs/e2fsprogs-1.35"
RDEPEND="!static? ( ${DEPEND} )"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf $(use_with ntfs) $(use_with reiserfs) || die
	if use static
	then
		emake smallstatic || die
	else
		emake || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	mv ${D}/usr/share/doc/${MY_P} ${D}/usr/share/doc/${PF}
	rm ${D}/usr/share/doc/${PF}/COPYING ${D}/usr/share/doc/${PF}/INSTALL
}

