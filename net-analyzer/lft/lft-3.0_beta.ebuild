# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/lft/lft-3.0_beta.ebuild,v 1.1 2007/03/20 20:52:05 cedk Exp $

inherit flag-o-matic

MY_P=${P/_beta/b}
DESCRIPTION="Layer Four Traceroute: an advanced traceroute implementation"
HOMEPAGE="http://oppleman.com/lft/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="VOSTROM"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

DEPEND="net-libs/libpcap"

S="${WORKDIR}/${MY_P}"

src_compile() {
	# avoid suid related security issues.
	append-ldflags $(bindnow-flags)

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc CHANGELOG README TODO
}
