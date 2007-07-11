# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/efibootmgr/efibootmgr-0.5.3.ebuild,v 1.3 2007/07/11 14:18:30 armin76 Exp $

inherit eutils flag-o-matic

DESCRIPTION="Interact with the EFI Boot Manager on IA-64 Systems"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="http://linux.dell.com/efibootmgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64"
IUSE=""

DEPEND="virtual/libc
	sys-apps/pciutils"

src_compile() {
	if built_with_use sys-apps/pciutils zlib ; then
		append-ldflags -lz
	fi

	emake || die "emake failed"
}

src_install() {
	dosbin src/efibootmgr/efibootmgr || die
	doman src/man/man8/efibootmgr.8
	dodoc AUTHORS README doc/ChangeLog doc/TODO
}
