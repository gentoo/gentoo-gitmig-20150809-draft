# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml/tclxml-2.5.ebuild,v 1.1 2003/02/02 04:37:49 agenkin Exp $

DESCRIPTION="Pure Tcl implementation of an XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"

DEPEND=">=dev-lang/tcl-8.3.3"

LICENSE="BSD"
KEYWORDS="~x86"

SLOT="0"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {

	econf || die
	make || die

}

src_install() {

        einstall || die
        dodoc ChangeLog LICENSE README RELNOTES

}
