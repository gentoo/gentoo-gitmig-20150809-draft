# Copyright 2003 Arcady Genkin <agenkin@gentoo.org>.
# Distributed under the terms of the GNU General Public License v2.
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml/tclxml-2.4.ebuild,v 1.3 2003/07/08 16:55:51 agenkin Exp $

DESCRIPTION="Pure Tcl implementation of an XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"

DEPEND=">=dev-lang/tcl-8.3.3"

LICENSE="BSD"
KEYWORDS="x86 ~alpha"

SLOT="0"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"
S=${WORKDIR}/${P}

src_compile() {

	econf || die
	make || die

        # Need to hack the config script.
        sed 's:NONE:/usr:' < TclxmlConfig.sh > TclxmlConfig.sh.hacked
        mv TclxmlConfig.sh.hacked TclxmlConfig.sh

}

src_install() {

        einstall || die
        dodoc ChangeLog LICENSE README RELNOTES

}
