# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/genromfs/genromfs-0.5.1.ebuild,v 1.4 2002/08/16 02:21:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Create space-efficient, small, read-only romfs filesystems"
SRC_URI="mirror://sourceforge/romfs/${P}.tar.gz"
HOMEPAGE="http://romfs.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}; cd ${S}
	cp Makefile Makefile.orig
	sed -e "s%^\(CFLAGS = \)-O2%\1${CFLAGS}%" Makefile.orig > Makefile
}

src_compile() {
	make || die
}

src_install() {
	dobin genromfs
	doman genromfs.8
	dodoc COPYING ChangeLog NEWS genromfs.lsm genrommkdev \
		readme-kernel-patch romfs.txt
}
