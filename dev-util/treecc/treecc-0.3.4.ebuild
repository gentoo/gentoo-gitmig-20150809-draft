# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/treecc/treecc-0.3.4.ebuild,v 1.6 2006/10/05 23:46:50 wormo Exp $

DESCRIPTION="compiler-compiler tool for aspect-oriented programming"
HOMEPAGE="http://www.southern-storm.com.au/treecc.html"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ppc64 sparc mips alpha arm hppa amd64 ia64 s390 ppc-macos"
IUSE=""

DEPEND=""

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
