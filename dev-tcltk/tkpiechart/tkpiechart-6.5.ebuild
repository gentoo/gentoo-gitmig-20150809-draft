# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tkpiechart/tkpiechart-6.5.ebuild,v 1.1 2004/05/16 23:27:08 matsuu Exp $

DESCRIPTION="create and update 2D or 3D pie charts in a Tcl/Tk application"
HOMEPAGE="http://jfontain.free.fr/piechart6.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.bz2"

LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/tk-8.3
	dev-tcltk/tcllib"

src_install() {
	dodir /usr/lib/tkpiechart
	./instapkg.tcl ${D}/usr/lib/tkpiechart || die

	dodoc CHANGES CONTENTS COPYRIGHT INSTALL README TODO
	dohtml *.gif *.html
	docinto demo
	dodoc demo*
}
