# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/efibootmgr/efibootmgr-0.4.2.ebuild,v 1.1 2004/01/21 20:41:47 agriffis Exp $

DESCRIPTION="Interact with the EFI Boot Manager on IA-64 Systems"
HOMEPAGE="http://developer.intel.com/technology/efi"

# This is efibootmgr, a Linux user-space application to modify the
# Intel Extensible Firmware Interface (EFI) Boot Manager. This
# application can create and destroy boot entries, change the boot
# order, change the next running boot option, and more.
#
# Note: efibootmgr requires that the kernel module efivars be loaded
# prior to use.  `modprobe efivars` should do the trick.

SRC_URI="http://domsch.com/linux/ia64/${PN}/${P}.tar.gz"
KEYWORDS="~ia64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/glibc"	# don't think there's anything else
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} && cd ${S} || die "failed to unpack"
	epatch ${FILESDIR}/efibootmgr-0.4.1-makefile.patch || die "epatch failed"
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	mkdir -p ${D}/usr/sbin
	install -m755 src/efibootmgr/efibootmgr ${D}/usr/sbin
	doman src/man/man8/efibootmgr.8
	dodoc AUTHORS COPYING README doc/ChangeLog doc/TODO
}
