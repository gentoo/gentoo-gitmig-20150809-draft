# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/calltree/calltree-0.2.95.ebuild,v 1.3 2003/07/12 23:19:41 aliz Exp $

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling"
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-util/valgrind-1.9.4"
src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall
	rm -r ${D}/usr/share/doc/valgrind
	dodoc AUTHORS INSTALL README
	dohtml docs/*.html
}
