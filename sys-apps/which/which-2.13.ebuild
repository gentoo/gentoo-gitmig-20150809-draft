# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/which/which-2.13.ebuild,v 1.4 2002/07/16 05:51:09 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Prints out location of specified executables that are in your path"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/which/${P}.tar.gz"
HOMEPAGE="http://www.xs4all.nl/~carlo17/which/"
KEYWORDS="x86 ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
    try ./configure --prefix=/usr
    try make
}

src_install() {
    dobin which
    doman which.1
    doinfo which.info
    dodoc AUTHORS COPYING EXAMPLES NEWS README*
}

