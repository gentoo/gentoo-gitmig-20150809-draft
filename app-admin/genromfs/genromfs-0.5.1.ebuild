# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/genromfs/genromfs-0.5.1.ebuild,v 1.14 2004/05/31 19:21:32 vapier Exp $

DESCRIPTION="Create space-efficient, small, read-only romfs filesystems"
HOMEPAGE="http://romfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/romfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc s390"
IUSE=""

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}; cd ${S}
	sed -i -e "s%^\(CFLAGS = \)-O2%\1${CFLAGS}%" Makefile
}

src_compile() {
	make || die
}

src_install() {
	dobin genromfs || die
	doman genromfs.8
	dodoc ChangeLog NEWS genromfs.lsm genrommkdev readme-kernel-patch romfs.txt
}
