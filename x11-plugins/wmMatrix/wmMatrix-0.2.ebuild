# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmMatrix/wmMatrix-0.2.ebuild,v 1.9 2004/11/28 19:00:03 s4t4n Exp $

IUSE=""
DESCRIPTION="WMaker DockApp: Slightly modified version of Jamie Zawinski's xmatrix screenhack."
SRC_URI="http://www.dockapps.org/download.php/id/17/${P}.tar.gz"
HOMEPAGE="http://www.dockapps.org/file.php/id/10"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc"

src_compile() {
	# this version is distributed with compiled binaries!
	make clean
	emake || die
}

src_install () {
	dobin wmMatrix
}
