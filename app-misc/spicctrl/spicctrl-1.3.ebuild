# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/spicctrl/spicctrl-1.3.ebuild,v 1.1 2002/10/13 09:17:56 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="spicctrl - Tool for the sonypi-Device (found in Sony Vaio Notebooks)"
HOMEPAGE="http://www.alcove-labs.org/en/software/sonypi/"
SRC_URI="http://download.alcove-labs.org/software/sonypi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -sparc64"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install () {
	dobin spicctrl
}
