# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml-expat/tclxml-expat-2.4.ebuild,v 1.4 2003/03/10 22:31:38 agriffis Exp $

DESCRIPTION="Tcl wrapper libraries for expat XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-libs/expat-1.95.4
	=dev-tcltk/tclxml-${PV}*"

LICENSE="BSD"
KEYWORDS="x86 ~alpha"

SLOT="0"
SRC_URI="mirror://sourceforge/tclxml/tclxml-${PV}.tar.gz"
S=${WORKDIR}/tclxml-${PV}/expat

src_compile() {

	econf --with-tcl=/usr/lib --with-Tclxml=/usr/lib || die
	make || die

}

src_install() {

	einstall || die
	dohtml expat.html

}
