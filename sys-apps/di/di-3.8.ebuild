# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/di/di-3.8.ebuild,v 1.7 2004/06/24 22:03:06 agriffis Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Disk Information Utility"
SRC_URI="http://www.gentoo.com/di/${P}.tar.gz"
HOMEPAGE="http://www.gentoo.com/di/"
KEYWORDS="x86 amd64"
LICENSE="as-is"
DEPEND=""
SLOT="0"

src_compile() {
	prefix=${D} ./Build || die
}

src_install () {
	doman di.1
	dobin di
	dosym /usr/bin/di /usr/bin/mi
	dodoc LICENSE README
}
