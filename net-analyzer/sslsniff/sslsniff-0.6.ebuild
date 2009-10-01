# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sslsniff/sslsniff-0.6.ebuild,v 1.1 2009/10/01 00:51:39 robbat2 Exp $

DESCRIPTION="MITM all SSL connections on a LAN and dynamically generates certs"
HOMEPAGE="http://thoughtcrime.org/software/sslsniff/"
SRC_URI="http://thoughtcrime.org/software/sslsniff/${P}.tar.gz"
LICENSE="GPL-3" # plus OpenSSL exception
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="dev-libs/boost
		dev-libs/log4cpp
		dev-libs/openssl"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Failed emake install"
	dodoc AUTHORS README

	insinto /usr/share/sslsniff
	doins leafcert.pem IPSCACLASEA1.crt

	insinto /usr/share/sslsniff/updates
	doins updates/*xml

	insinto /usr/share/sslsniff/certs
	doins certs/*
}
