# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/squashfs-tools/squashfs-tools-2.0_alpha.ebuild,v 1.1 2004/06/04 08:49:18 dragonheart Exp $

MY_PV=${PV/_alpha/-ALPHA}
DESCRIPTION="Tool for creating compressed filesystem type squashfs"
HOMEPAGE="http://squashfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/squashfs/squashfs${MY_PV}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64 ~s390"
IUSE=""

DEPEND="virtual/glibc
	sys-libs/zlib"

S=${WORKDIR}/squashfs${PV/_alpha}/squashfs-tools

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
