# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/chaosreader/chaosreader-0.94.ebuild,v 1.4 2005/08/12 00:08:50 tester Exp $

DESCRIPTION="A tool to trace TCP/UDP/... sessions and fetch application data from snoop or tcpdump logs."
HOMEPAGE="http://users.tpg.com.au/bdgcvb/chaosreader.html"
SRC_URI="http://dev.gentoo.org/~spock/portage/distfiles/${P}.bz2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2"
IUSE=""
DEPEND=">=dev-lang/perl-5.8.0"
S=${WORKDIR}

src_install() {
	newbin ${S}/${P} chaosreader
}
