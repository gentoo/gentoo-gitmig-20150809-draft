# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/spicctrl/spicctrl-1.4.ebuild,v 1.1 2002/11/17 22:08:55 hanno Exp $

S=${WORKDIR}/${P}
DESCRIPTION="spicctrl - Tool for the sonypi-Device (found in Sony Vaio Notebooks)"
HOMEPAGE="http://spop.free.fr/sonypi/"
SRC_URI="http://spop.free.fr/sonypi/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -sparc64"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin spicctrl
}
