# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/syslinux/syslinux-2.05.ebuild,v 1.4 2004/07/15 02:52:27 agriffis Exp $

inherit eutils

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/${P}.tar.bz2"

KEYWORDS="x86 -ppc -sparc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/nasm
	sys-fs/mtools"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.06-nasm.patch
	sed -i 's:$(MAKE) -C win32 all::' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc README NEWS TODO *.doc memdisk/memdisk.doc
}
