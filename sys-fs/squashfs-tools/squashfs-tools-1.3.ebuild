# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-1.3.ebuild,v 1.4 2004/09/03 19:16:59 pvdabeel Exp $

MY_PV="1.3r3"
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips ~alpha arm hppa amd64 ~ia64 ~ppc64 s390"
IUSE=""

DEPEND="virtual/libc
	sys-libs/zlib"

S=${WORKDIR}/squashfs${MY_PV}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin mksquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES
}
