# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/callgrind/callgrind-0.9.10-r1.ebuild,v 1.3 2005/03/28 13:33:54 caleb Exp $

inherit eutils

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind"
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RDEPEND="=dev-util/valgrind-2.2*"
DEPEND="${RDEPEND}
	!dev-util/calltree"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/callgrind-sim-pic.patch
}

src_install() {
	einstall || die
	rm -rf ${D}/usr/share/doc/valgrind
	dodoc AUTHORS INSTALL README || die "dodoc failed"
	dohtml docs/*.html || die "dohtml failed"
}
