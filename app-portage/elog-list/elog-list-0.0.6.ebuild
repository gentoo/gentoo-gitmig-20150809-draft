# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/elog-list/elog-list-0.0.6.ebuild,v 1.1 2007/10/15 19:28:57 mpagano Exp $

DESCRIPTION="A console based helper script for managing Gentoo elogs generated during the emerge process"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=29"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	cd "${S}"
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}
