# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/cromwell/cromwell-2.40-r2.ebuild,v 1.2 2007/07/02 15:30:28 peper Exp $

inherit eutils mount-boot

IUSE=""
DESCRIPTION="Xbox boot loader"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.xbox-linux.org"
RESTRICT="${RESTRICT} strip"
DEPEND=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* x86"
PROVIDE="virtual/bootloader"

src_unpack() {
	unpack ${A}

	cd ${S}; epatch ${FILESDIR}/${P}-cvs-fixes.patch
}

src_compile() {
	emake -j1 || die
}

src_install () {
	dodir /boot/${PN}
	insinto /boot/${PN}
	doins ${S}/image/cromwell.bin ${S}/image/cromwell_1024.bin ${S}/xbe/xromwell.xbe || die
}
