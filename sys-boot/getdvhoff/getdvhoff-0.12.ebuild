# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/getdvhoff/getdvhoff-0.12.ebuild,v 1.1 2005/09/11 21:46:41 kumba Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Utility for use on LiveCDs to calculate offset of the ext2 partition for losetup"
HOMEPAGE="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/"
SRC_URI="ftp://ftp.linux-mips.org/pub/linux/mips/people/skylark/sgibootcd-${PV}.tar.bz2"
LICENSE="as-is"
SLOT="0"
KEYWORDS="-* mips"
IUSE=""
DEPEND=""
RESTRICT="nostrip"
S="${WORKDIR}/sgibootcd-${PV}"
MY_S="${S}/helpers"


src_compile() {
	cd ${MY_S}
	local mycc="$(tc-getCC) ${CFLAGS} -static"

	[ -f "${MY_S}/getdvhoff" ] && rm -f ${MY_S}/getdvhoff
	einfo "${mycc} getdvhoff.c -o getdvhoff"
	${mycc} getdvhoff.c -o getdvhoff
}

src_install() {
	cd ${MY_S}
	dodir /usr/lib/getdvhoff
	cp ${MY_S}/getdvhoff ${D}/usr/lib/getdvhoff
}
