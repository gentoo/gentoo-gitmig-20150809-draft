# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/efibootmgr/efibootmgr-0.5.3.ebuild,v 1.4 2007/08/14 21:26:02 wolf31o2 Exp $

inherit eutils flag-o-matic

DESCRIPTION="Interact with the EFI Boot Manager on IA-64 Systems"
HOMEPAGE="http://developer.intel.com/technology/efi"
SRC_URI="http://linux.dell.com/efibootmgr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64"
IUSE="zlib"

DEPEND="virtual/libc
	zlib? ( sys-libs/zlib )
	sys-apps/pciutils"

src_compile() {
	if use zlib
	then
		append-ldflags -lz
	elif built_with_use --missing false sys-apps/pciutils zlib
	then
		die "You need to build with USE=zlib to match sys-apps/pcituils"
	fi

	emake || die "emake failed"
}

src_install() {
	dosbin src/efibootmgr/efibootmgr || die
	doman src/man/man8/efibootmgr.8
	dodoc AUTHORS README doc/ChangeLog doc/TODO
}
