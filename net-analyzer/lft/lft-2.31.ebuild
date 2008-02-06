# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-2.31.ebuild,v 1.8 2008/02/06 20:46:22 grobian Exp $

inherit flag-o-matic

DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://oppleman.com/lft/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="VOSTROM"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="net-libs/libpcap"

src_compile() {
	# avoid suid related security issues.
	append-ldflags $(bindnow-flags)

	econf || die
	emake || die
}

src_install() {
	einstall || die "einstall failed"
	dodoc CHANGELOG README TODO
}
