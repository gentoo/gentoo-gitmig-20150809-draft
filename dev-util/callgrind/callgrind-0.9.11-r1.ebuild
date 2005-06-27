# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/callgrind/callgrind-0.9.11-r1.ebuild,v 1.3 2005/06/27 20:41:46 caleb Exp $

inherit eutils

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind."
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-util/valgrind-2.2.0
	!dev-util/calltree"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-pic.patch"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog README TODO
	dohtml docs/*.html
}
