# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-1.5.7.ebuild,v 1.3 2008/01/30 01:29:29 cla Exp $

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	cd "${S}"
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}
