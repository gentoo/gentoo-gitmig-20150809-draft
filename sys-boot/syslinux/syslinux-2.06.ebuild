# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/syslinux/syslinux-2.06.ebuild,v 1.2 2003/12/30 23:31:52 pauldv Exp $ 

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/${P}.tar.bz2"

KEYWORDS="~x86 -ppc -sparc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/nasm
	sys-fs/mtools"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-nasm.patch
	sed -i 's:$(MAKE) -C win32 all::' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc README NEWS TODO *.doc memdisk/memdisk.doc
}
