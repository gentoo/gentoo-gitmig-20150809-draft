# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/syslinux/syslinux-2.09.ebuild,v 1.6 2005/01/10 00:26:54 vapier Exp $

inherit eutils gcc

DESCRIPTION="SysLinux, IsoLinux and PXELinux bootloader"
HOMEPAGE="http://syslinux.zytor.com/"
SRC_URI="mirror://kernel/linux/utils/boot/syslinux/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""

DEPEND="dev-lang/nasm
	sys-fs/mtools"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/2.06-nasm.patch
	# -fstack-protector really does not play along well with any boot loader
	$(gcc-getCC) -fstack-protector -S -o /dev/null -xc /dev/null >/dev/null 2>&1 && \
		epatch ${FILESDIR}/${PN}-2.09-nossp.patch
	sed -i 's:$(MAKE) -C win32 all::' Makefile
}

src_compile() {
	emake || die
}

src_install() {
	make INSTALLROOT=${D} install || die
	dodoc README NEWS TODO *.doc memdisk/memdisk.doc
}
