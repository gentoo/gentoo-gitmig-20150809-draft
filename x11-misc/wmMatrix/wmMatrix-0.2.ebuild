# Copyright (c) Vitaly Kushneriuk
# Distributed under the terms of the GNU General Public License, v2.
# Maintainer: Vitaly Kushneriuk<vitaly@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmMatrix/wmMatrix-0.2.ebuild,v 1.2 2002/07/08 16:58:06 aliz Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMaker DockApp: Slightly modified version of Jamie Zawinski's xmatrix screenhack."
SRC_URI="http://nis-www.lanl.gov/~mgh/WindowMaker/${P}.tar.gz"
HOMEPAGE="http://nis-www.lanl.gov/~mgh/WindowMaker/DockApps.shtml"
DEPEND="virtual/glibc x11-base/xfree"
LICENSE="GPL-2"

src_compile() {
	# this version is distributed with compiled binaries!
	make clean
	emake || die
}

src_install () {
	dobin wmMatrix
}
