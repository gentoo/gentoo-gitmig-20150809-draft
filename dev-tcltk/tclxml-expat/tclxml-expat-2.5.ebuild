# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml-expat/tclxml-expat-2.5.ebuild,v 1.2 2003/08/07 03:22:19 vapier Exp $

DESCRIPTION="Tcl wrapper libraries for expat XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/tclxml-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-x86"

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
