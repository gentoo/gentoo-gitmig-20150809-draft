# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-3.0.ebuild,v 1.4 2006/04/22 08:22:17 corsair Exp $

inherit toolchain-funcs

MY_PV=${PV/_p/r}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/libc
	sys-libs/zlib"

S=${WORKDIR}/squashfs${PV/_p/-r}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES README-2.{0,1} README-AMD64 \
		PERFORMANCE.README README-3.0
}
