# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/silo/silo-1.3.2.ebuild,v 1.1 2003/12/09 08:13:26 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="http://www.sparc-boot.org/pub/silo/${P}.tar.gz"
HOMEPAGE="http://www.sparc-boot.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~sparc"

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
