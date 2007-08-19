# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/jfsutils/jfsutils-1.1.11-r2.ebuild,v 1.1 2007/08/19 08:57:44 phreak Exp $

inherit eutils flag-o-matic

DESCRIPTION="IBM's Journaling Filesystem (JFS) Utilities"
HOMEPAGE="http://jfs.sourceforge.net/"
SRC_URI="http://jfs.sourceforge.net/project/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fsck-n.patch
	epatch "${FILESDIR}"/${P}-double-close.patch
}

src_compile() {
	use static && append-ldflags -static
	econf --sbindir=/sbin || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die

	rm -f ${D}/sbin/mkfs.jfs fsck.jfs
	dosym /sbin/jfs_mkfs /sbin/mkfs.jfs
	dosym /sbin/jfs_fsck /sbin/fsck.jfs

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
