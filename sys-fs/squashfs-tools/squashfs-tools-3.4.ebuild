# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-3.4.ebuild,v 1.1 2008/08/28 03:36:00 jer Exp $

inherit toolchain-funcs

MY_PV=${PV/_p/-r}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="sys-libs/zlib"

S=${WORKDIR}/squashfs${PV/_p/-r}/squashfs-tools

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:-O2:${CFLAGS}:" \
		-e 's:$(CC):$(CC) ${LDFLAGS}:' \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin mksquashfs unsquashfs || die
	cd ..
	dodoc README ACKNOWLEDGEMENTS CHANGES PERFORMANCE.README README
}

pkg_postinst() {
	ewarn "This version of mksquashfs requires a 2.6.24 kernel or better."
}
