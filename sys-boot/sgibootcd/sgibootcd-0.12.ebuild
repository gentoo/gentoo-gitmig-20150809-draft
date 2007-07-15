# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/sgibootcd/sgibootcd-0.12.ebuild,v 1.2 2007/07/15 02:25:03 mr_bones_ Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Creates burnable CD images for SGI LiveCDs"
HOMEPAGE="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/"
SRC_URI="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/${P}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""
DEPEND=""
RESTRICT=""

src_compile() {
	cd ${S}
	local mycc="$(tc-getCC) ${CFLAGS}"

	[ -f "${S}/sgibootcd" ] && rm -f ${S}/sgibootcd
	einfo "${mycc} sgibootcd.c -o sgibootcd"
	${mycc} sgibootcd.c -o sgibootcd
}

src_install() {
	cd ${S}
	dobin ${S}/sgibootcd
}
