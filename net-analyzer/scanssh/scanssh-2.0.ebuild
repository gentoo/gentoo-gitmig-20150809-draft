# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanssh/scanssh-2.0.ebuild,v 1.1 2004/07/16 18:27:48 aliz Exp $

#S=${WORKDIR}/scanssh
DESCRIPTION="scanssh protocol scanner scans a list of addresses an networks for running SSH protocol servers and their version numbers."
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"
HOMEPAGE="http://monkey.org/~provos/scanssh/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

RDEPEND=""
DEPEND="net-libs/libpcap
		dev-libs/libdnet
		>=dev-libs/libevent-0.8a"

src_install() {
	doman scanssh.1
	dobin scanssh
}
