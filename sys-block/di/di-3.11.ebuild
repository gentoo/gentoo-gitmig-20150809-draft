# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/di/di-3.11.ebuild,v 1.6 2006/04/04 15:19:41 agriffis Exp $

inherit toolchain-funcs

DESCRIPTION="Disk Information Utility"
HOMEPAGE="http://www.gentoo.com/di/"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 x86"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND=""

src_compile() {
	tc-export CC
	SHELL=/bin/bash prefix=${D} ./Build || die
}

src_install() {
	doman di.1
	dobin di || die
	dosym di /usr/bin/mi
	dodoc README
}
