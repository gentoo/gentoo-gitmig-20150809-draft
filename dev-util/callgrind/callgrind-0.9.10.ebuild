# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/callgrind/callgrind-0.9.10.ebuild,v 1.1 2004/11/22 13:07:18 caleb Exp $

inherit eutils

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind"
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND=">=dev-util/valgrind-2.2.0"
DEPEND="${RDEPEND}
	!dev-util/calltree"

src_install() {
	einstall                     || die
	rm -rf ${D}/usr/share/doc/valgrind
	dodoc AUTHORS INSTALL README || die "dodoc failed"
	dohtml docs/*.html           || die "dohtml failed"
}
