# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/xtail/xtail-2.1.ebuild,v 1.18 2005/01/01 11:37:12 eradicator Exp $

DESCRIPTION="Tail multiple logfiles at once, even if rotated"
HOMEPAGE="http://www.unicom.com/sw/xtail/"
SRC_URI="http://www.unicom.com/sw/xtail/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	doman xtail.1
	dobin xtail || die
	dodoc README
}
