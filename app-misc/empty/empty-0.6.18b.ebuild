# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/empty/empty-0.6.18b.ebuild,v 1.1 2012/06/18 16:40:50 maksbotan Exp $

EAPI="4"
inherit eutils

DESCRIPTION="Small shell utility, similar to expect(1)"
HOMEPAGE="http://empty.sourceforge.net"
SRC_URI="mirror://sourceforge/empty/${P}.tgz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="examples"
DEPEND=""
RDEPEND="virtual/logger"

src_prepare() {
	epatch "${FILESDIR}/overflow-fixes.patch"
}

src_install() {
	dobin empty
	doman empty.1
	dodoc README
	use examples && dodoc -r examples
}
