# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="SPARC/UltraSPARC Improved Loader, a boot loader for sparc"
SRC_URI="http://www.ultralinux.nl/silo/download/${A}"
HOMEPAGE="http://freshmeat.net/projects/silo/index.html"
KEYWORDS="sparc sparc64 -x86 -ppc"
SLOT="0"
LICENSE="GPL-2"
DEPEND="sys-apps/e2fsprogs sys-apps/sparc-utils"

src_compile() {

    try make ${MAKEOPTS}

}

src_install() {

    try make DESTDIR=${D} install

}
