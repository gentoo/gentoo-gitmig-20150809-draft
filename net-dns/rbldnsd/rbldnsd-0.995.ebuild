# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/rbldnsd/rbldnsd-0.995.ebuild,v 1.1 2005/08/15 22:05:32 chriswhite Exp $

inherit eutils
DESCRIPTION="a DNS daemon which is designed to serve DNSBL zones"
HOMEPAGE="http://www.corpit.ru/mjt/rbldnsd.html"
SRC_URI="http://www.corpit.ru/mjt/rbldnsd/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	./configure || die "Configuration failed"
	emake || die "Configuration failed"
}

src_install() {
	dosbin rbldnsd
	doman rbldnsd.8
	keepdir /var/db/rbldnsd
	dodoc CHANGES* TODO NEWS README* ${FILESDIR}/example
	newinitd ${FILESDIR}/initd rbldnsd
	newconfd ${FILESDIR}/confd rbldnsd
}

pkg_postinst() {
	enewgroup rbldns 800
	enewuser rbldns 800 /bin/false /var/db/rbldnsd rbldns
	einfo "for testing purpose, example zone file has been installed"
	einfo "see /usr/share/doc/${PF}/example."
}
