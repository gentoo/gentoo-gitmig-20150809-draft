# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/spicctrl/spicctrl-1.6.ebuild,v 1.1 2004/03/08 06:05:40 latexer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="spicctrl - tool for the sonypi-Device (found in Sony Vaio Notebooks)"
HOMEPAGE="http://spop.free.fr/sonypi/"
SRC_URI="http://spop.free.fr/sonypi/${P}.tar.bz2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin spicctrl
}
