# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmapm/wmapm-3.1-r1.ebuild,v 1.11 2005/10/31 13:35:48 nelchael Exp $

IUSE=""
S=${WORKDIR}/${P}/${PN}
DESCRIPTION="WindowMaker DockApp: Battery/Power status monitor for laptops"
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"

DEPEND="virtual/x11"

src_install () {
	cd ${S}
	dobin wmapm
	doman wmapm.1

	cd ..
	dodoc BUGS CHANGES HINTS README TODO
}
