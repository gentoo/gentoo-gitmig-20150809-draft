# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xcircuit/xcircuit-2.5.5.ebuild,v 1.8 2004/07/15 03:45:35 agriffis Exp $

inherit flag-o-matic

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://xcircuit.ece.jhu.edu/archive/${P}.tar.bz2"
HOMEPAGE="http://xcircuit.ece.jhu.edu"

KEYWORDS="x86 ~ppc"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/x11
		dev-lang/python
		virtual/ghostscript"

#looks like -O3 causes problems at times
replace-flags -O3 -O2

src_compile() {
	econf || die "./configure failed"

	#Parallel make bombs on parameter.c looking for menudep.h
	make || die
}

src_install () {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc COPYRIGHT README*
}
