# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jfsutils/jfsutils-1.1.1-r1.ebuild,v 1.2 2004/04/10 01:20:53 kumba Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
HOMEPAGE="http://www-124.ibm.com/developerworks/oss/jfs/index.html"
SRC_URI="http://www10.software.ibm.com/developer/opensource/jfs/project/pub/${P}.tar.gz
	mirror://gentoo/${P}-errno.diff.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -ppc"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# Patch to allow compilation with glibc-2.3.2
	# (the infamous errno issue)
	epatch ${WORKDIR}/${P}-errno.diff
}


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
