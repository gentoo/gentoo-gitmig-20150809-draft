# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/radeontool/radeontool-1.0.ebuild,v 1.2 2004/06/14 08:39:57 kloeri Exp $

DESCRIPTION="Control the backlight and external video output of ATI Radeon Mobility graphics cards"
HOMEPAGE="http://fdd.com/software/radeon/"
SRC_URI="http://fdd.com/software/radeon/${P}.tar.gz"
LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-apps/pciutils"
S=${WORKDIR}

src_compile() {
	gcc -Wall ${CFLAGS} -o radeontool radeontool.c || die
}

src_install() {
	dobin radeontool
}
