# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/calltree/calltree-0.9.7.ebuild,v 1.1 2004/04/05 18:32:49 caleb Exp $

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind"
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=dev-util/valgrind-2.1.0"

src_install() {
	einstall                     || die
	rm -rf ${D}/usr/share/doc/valgrind
	dodoc AUTHORS INSTALL README || die "dodoc failed"
	dohtml docs/*.html           || die "dohtml failed"
}
