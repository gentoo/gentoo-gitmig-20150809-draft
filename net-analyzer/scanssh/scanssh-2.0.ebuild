# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanssh/scanssh-2.0.ebuild,v 1.4 2005/02/01 00:02:48 ka0ttic Exp $

DESCRIPTION="network scanner that gathers info on SSH protocols and versions"
HOMEPAGE="http://monkey.org/~provos/scanssh/"
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=""
DEPEND="virtual/libpcap
	dev-libs/libdnet
	>=dev-libs/libevent-0.8a"

src_install() {
	doman scanssh.1
	dobin scanssh || die
}
