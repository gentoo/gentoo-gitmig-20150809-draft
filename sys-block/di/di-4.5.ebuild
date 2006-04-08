# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/di/di-4.5.ebuild,v 1.1 2006/04/08 01:10:45 vapier Exp $

inherit toolchain-funcs

DESCRIPTION="Disk Information Utility"
HOMEPAGE="http://www.gentoo.com/di/"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND=""

src_compile() {
	tc-export CC
	SHELL=/bin/bash prefix="${D}" ./Build || die
}

src_install() {
	doman di.1
	dobin di || die
	dosym di /usr/bin/mi
	dodoc README
}
