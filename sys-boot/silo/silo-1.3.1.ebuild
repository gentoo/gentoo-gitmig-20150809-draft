# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/silo/silo-1.3.1.ebuild,v 1.7 2005/03/28 13:35:56 gustavoz Exp $

DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="http://www.sparc-boot.org/pub/silo/old/${P}.tar.gz"
HOMEPAGE="http://www.sparc-boot.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* sparc"
IUSE=""

PROVIDE="virtual/bootloader"

DEPEND="sys-fs/e2fsprogs
	sys-apps/sparc-utils"

src_compile() {
	make ${MAKEOPTS} || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog first-isofs/README.SILO_ISOFS docs/README*
}

pkg_postinst() {
	ewarn "NOTE: If this is an upgrade to an existing SILO install,"
	ewarn "      you will need to re-run silo as the /boot/second.b"
	ewarn "      file has changed, else the system will fail to load"
	ewarn "      SILO at the next boot."
}
