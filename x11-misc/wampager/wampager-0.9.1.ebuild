# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wampager/wampager-0.9.1.ebuild,v 1.6 2004/06/24 22:35:45 agriffis Exp $

DESCRIPTION="Pager for Waimea"
SRC_URI="mirror://sourceforge/waimea/${P}.tar.gz"
HOMEPAGE="http://waimea.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="x11-wm/waimea"

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin wampager || die
}
