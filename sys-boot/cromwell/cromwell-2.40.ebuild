# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/cromwell/cromwell-2.40.ebuild,v 1.1 2005/08/10 20:39:31 chrb Exp $

inherit mount-boot

IUSE=""
DESCRIPTION="Xbox boot loader"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.xbox-linux.org"
RESTRICT="${RESTRICT} nostrip"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* x86"
PROVIDE="virtual/bootloader"

src_compile() {
	emake -j1 || die
}

src_install () {
	dodir /boot/${PN}
	insinto /boot/${PN}
	doins ${S}/image/cromwell.bin ${S}/image/cromwell_1024.bin ${S}/xbe/xromwell.xbe || die
}
