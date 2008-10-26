# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bti/bti-007.ebuild,v 1.1 2008/10/26 17:22:26 gregkh Exp $

DESCRIPTION="A command line twitter/identi.ca client"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/gregkh/bti/"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/gregkh/bti/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	doman bti.1
	dobin bti
	dodoc bti.example README RELEASE-NOTES
}
