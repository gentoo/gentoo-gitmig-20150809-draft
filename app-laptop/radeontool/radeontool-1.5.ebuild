# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/radeontool/radeontool-1.5.ebuild,v 1.4 2005/01/01 14:48:29 eradicator Exp $

DESCRIPTION="Control the backlight and external video output of ATI Radeon Mobility graphics cards"
HOMEPAGE="http://fdd.com/software/radeon/"
SRC_URI="http://fdd.com/software/radeon/${P}.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ~amd64"
IUSE=""
DEPEND="sys-apps/pciutils"

src_compile() {
	gcc -Wall ${CFLAGS} -o radeontool radeontool.c || die
}

src_install() {
	dobin radeontool
	dodoc CHANGES
}
