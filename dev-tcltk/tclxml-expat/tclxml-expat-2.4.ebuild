# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml-expat/tclxml-expat-2.4.ebuild,v 1.10 2004/06/19 20:45:06 weeve Exp $

DESCRIPTION="Tcl wrapper libraries for expat XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/tclxml-${PV}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 alpha ~sparc"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-libs/expat-1.95.4
	=dev-tcltk/tclxml-${PV}*"

S=${WORKDIR}/tclxml-${PV}/expat

src_compile() {
	econf --with-tcl=/usr/lib --with-Tclxml=/usr/lib || die
	make || die
}

src_install() {
	einstall || die
	dohtml expat.html
}
