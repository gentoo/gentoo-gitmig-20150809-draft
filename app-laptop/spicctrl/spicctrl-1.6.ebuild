# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/spicctrl/spicctrl-1.6.ebuild,v 1.3 2004/06/24 21:59:55 agriffis Exp $

DESCRIPTION="spicctrl - tool for the sonypi-Device (found in Sony Vaio Notebooks)"
HOMEPAGE="http://spop.free.fr/sonypi/"
SRC_URI="http://spop.free.fr/sonypi/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin spicctrl || die "dobin failed"
}
