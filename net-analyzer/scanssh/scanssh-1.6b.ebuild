# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/scanssh/scanssh-1.6b.ebuild,v 1.10 2005/01/29 05:12:51 dragonheart Exp $

S=${WORKDIR}/scanssh
DESCRIPTION="Scanssh protocol scanner - scans a list of addresses an networks for running SSH protocol servers and their version numbers."
SRC_URI="http://monkey.org/~provos/${P}.tar.gz"
HOMEPAGE="http://monkey.org/~provos/scanssh/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc sparc"
IUSE=""

DEPEND="virtual/libpcap"

src_install() {
	doman scanssh.1
	dobin scanssh
}
