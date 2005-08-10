# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/callgrind/callgrind-0.9.12.ebuild,v 1.1 2005/08/10 12:38:55 caleb Exp $

inherit eutils

DESCRIPTION="A plugin for cachegrind that adds call-graph profiling, needed by kcachegrind."
HOMEPAGE="http://kcachegrind.sourceforge.net/"
SRC_URI="http://kcachegrind.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=dev-util/valgrind-2*
	!dev-util/calltree"

src_install() {
	make DESTDIR="${D}" install || die

	# Installs docs into stray directory
	rm -rf ${D}/usr/share/doc/valgrind

	dodoc AUTHORS ChangeLog README TODO
	dohtml docs/*.html
}
