# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/fpdns/fpdns-0.9.1.ebuild,v 1.1 2008/04/16 21:20:20 wschlich Exp $

IUSE=""
DESCRIPTION="Fingerprinting DNS servers"
HOMEPAGE="http://www.rfc.se/fpdns/"
SRC_URI="http://www.rfc.se/fpdns/distfiles/${P}.tar.gz"
LICENSE="fpdns"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND=">=dev-perl/Net-DNS-0.42"

src_compile() { :; }

src_install() {
	newbin fpdns.pl fpdns
	doman fpdns.1
}
