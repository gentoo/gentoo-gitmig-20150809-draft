# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/scwoop/scwoop-4.1.ebuild,v 1.1 2004/05/16 23:32:57 matsuu Exp $

DESCRIPTION="Simple Composite Widget Object Oriented Package"
HOMEPAGE="http://jfontain.free.fr/scwoop41.htm"
SRC_URI="http://jfontain.free.fr/${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

DEPEND="dev-tcltk/tcllib"

src_install() {
	dodir /usr/lib/scwoop
	./instapkg.tcl ${D}/usr/lib/scwoop || die

	dodoc CHANGES CONTENTS COPYRIGHT INSTALL README TODO
	dohtml scwoop.htm
	docinto demo
	dodoc demo*
}
