# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/chaosreader/chaosreader-0.92.ebuild,v 1.1 2004/02/01 18:03:17 spock Exp $

DESCRIPTION="A tool to trace TCP/UDP/... sessions and fetch application data from snoop or tcpdump logs."
HOMEPAGE="http://users.tpg.com.au/bdgcvb/chaosreader.html"
SRC_URI="http://dev.gentoo.org/~spock/portage/distfiles/${P}.bz2"
LICENSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"
IUSE=""
DEPEND=">=dev-lang/perl-5.8.0"
S=${WORKDIR}

src_install() {
	newbin ${S}/${P} chaosreader
}
