# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/treecc/treecc-0.3.0.ebuild,v 1.9 2004/07/25 12:32:34 scandium Exp $

DESCRIPTION="compiler-compiler tool for aspect-oriented programming"
HOMEPAGE="http://www.southern-storm.com.au/treecc.html"
SRC_URI="http://www.southern-storm.com.au/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc mips alpha arm hppa amd64 ia64 s390"

IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
