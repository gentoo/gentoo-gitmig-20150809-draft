# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslinux/syslinux-2.05.ebuild,v 1.2 2003/09/03 04:16:12 vapier Exp $ 

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/${P}.tar.bz2"

KEYWORDS="x86 amd64 -ppc -sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/nasm
	app-admin/mtools"

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
	dodoc README NEWS TODO *.doc
}
