# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/efibootmgr/efibootmgr-0.5.0.ebuild,v 1.1 2004/10/31 04:23:08 vapier Exp $

inherit eutils

DESCRIPTION="Interact with the EFI Boot Manager on IA-64 Systems"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="http://linux.dell.com/efibootmgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/efibootmgr-0.4.1-makefile.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin src/efibootmgr/efibootmgr || die
	doman src/man/man8/efibootmgr.8
	dodoc AUTHORS README doc/ChangeLog doc/TODO
}
