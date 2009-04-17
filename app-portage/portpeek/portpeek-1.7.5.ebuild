# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-1.7.5.ebuild,v 1.1 2009/04/17 18:31:02 mpagano Exp $

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI="http://www.mpagano.com/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-portage/gentoolkit-0.2.4
	>=sys-apps/portage-2.2_rc23"

src_install() {
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}
