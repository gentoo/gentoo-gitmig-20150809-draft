# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslinux/syslinux-2.01.ebuild,v 1.3 2003/05/25 15:23:52 mholzer Exp $ 

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/${P}.tar.bz2"

KEYWORDS="~x86 -ppc -sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-lang/nasm"

src_compile() {
	emake || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc README NEWS TODO *.doc
}
