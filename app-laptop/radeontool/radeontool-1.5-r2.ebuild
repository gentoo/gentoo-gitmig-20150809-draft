# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/radeontool/radeontool-1.5-r2.ebuild,v 1.1 2005/08/26 10:47:06 brix Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Control the backlight and external video output of ATI Radeon Mobility graphics cards"

HOMEPAGE="http://fdd.com/software/radeon/"
SRC_URI="http://fdd.com/software/radeon/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="sys-apps/sed"
RDEPEND="sys-apps/pciutils"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-mmap.patch
	epatch ${FILESDIR}/${P}-vga-ati.patch

	sed -i \
		-e "s:-Wall -O2:${CFLAGS}:" \
		-e "s:gcc:$(tc-getCC):" \
		${S}/Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin radeontool
	dodoc CHANGES
}
