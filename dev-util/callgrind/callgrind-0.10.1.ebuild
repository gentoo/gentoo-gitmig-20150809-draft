# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/callgrind/callgrind-0.10.1.ebuild,v 1.1 2006/01/12 03:06:18 lu_zero Exp $

inherit eutils

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind."
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE=""

DEPEND=">=dev-util/valgrind-3.1
	!dev-util/calltree"

src_install() {
	make DESTDIR="${D}" install || die

	# Installs docs into stray directory
	rm -rf ${D}/usr/share/doc/valgrind

	dodoc AUTHORS ChangeLog README TODO
	dohtml docs/*.html
}
