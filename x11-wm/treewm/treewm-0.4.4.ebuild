# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/treewm/treewm-0.4.4.ebuild,v 1.2 2004/02/18 15:22:36 lordvan Exp $

DESCRIPTION="WindowManager that arranges the windows in a tree not a list"
SRC_URI="mirror://sourceforge/treewm/${P}.tar.bz2"
HOMEPAGE="http://treewm.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"

DEPEND="virtual/glibc
	virtual/x11
	sys-apps/chpax"



src_compile() {
	make PREFIX=/usr || die
}

src_install() {
	make PREFIX=${D}/usr install || die

	dodoc ChangeLog README AUTHORS default.cfg sample.cfg TODO README.tiling PROBLEMS
}
