# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/doclifter/doclifter-2.3.ebuild,v 1.1 2007/08/25 12:42:36 vapier Exp $

DESCRIPTION="translate documents written in troff macros to DocBook"
HOMEPAGE="http://www.catb.org/~esr/doclifter/"
SRC_URI="http://www.catb.org/~esr/doclifter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-lang/python"

src_compile() { :; }

src_install() {
	dobin {doc,man}lifter || die
	doman {doc,man}lifter.1
	dodoc BUGS README TODO
}
