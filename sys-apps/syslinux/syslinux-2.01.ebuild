# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syslinux/syslinux-2.01.ebuild,v 1.1 2003/02/02 00:19:39 vapier Exp $ 

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="ftp://ftp.kernel.org/pub/linux/utils/boot/syslinux/${P}.tar.bz2"

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
