# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wampager/wampager-0.9.3.ebuild,v 1.5 2004/09/13 01:52:50 weeve Exp $

DESCRIPTION="Pager for Waimea"
# Temporary mirror until SF's CVS goes back online
SRC_URI="http://www.cs.umu.se/~c99drn/waimea/${P}.tar.gz"
HOMEPAGE="http://waimea.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
IUSE=""

DEPEND="x11-wm/waimea"

src_compile() {
	econf || die "econf failed"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dobin wampager || die
}
