# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/xcircuit/xcircuit-2.5.5.ebuild,v 1.5 2004/01/05 13:12:30 plasmaroo Exp $

IUSE=""

inherit flag-o-matic

S=${WORKDIR}/${P}

DESCRIPTION="Circuit drawing and schematic capture program."
SRC_URI="http://xcircuit.ece.jhu.edu/archive/${P}.tar.bz2"
HOMEPAGE="http://xcircuit.ece.jhu.edu"

KEYWORDS="x86 ~ppc"
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
