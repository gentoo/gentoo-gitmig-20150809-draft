# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Hanno Boeck <hanno@gmx.de>
# /space/gentoo/cvsroot/gentoo-x86/skel.ebuild,v 1.7 2002/05/18 17:25:12 agenkin Exp


DESCRIPTION="spicctrl 1.2 - Tool for the sonypi-Device (found in Sony Vaio Notebooks)"
HOMEPAGE="http://www.alcove-labs.org/en/software/sonypi/"
LICENSE="GPL"
DEPEND=""
RDEPEND="${DEPEND}"
SRC_URI="http://download.alcove-labs.org/software/sonypi/${P}.tar.bz2"
S=${WORKDIR}/${P}
SLOT="0"
KEYWORDS="x86"

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -Wstrict-prototypes" || die
}

src_install () {
	dobin spicctrl
}
