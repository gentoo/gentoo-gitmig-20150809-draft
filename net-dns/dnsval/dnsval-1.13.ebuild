# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsval/dnsval-1.13.ebuild,v 1.1 2012/06/23 21:19:16 xmw Exp $

EAPI=4

inherit eutils

DESCRIPTION="DNSSEC validator library"
HOMEPAGE="http://www.dnssec-tools.org/"
SRC_URI="http://www.dnssec-tools.org/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 +threads"

RDEPEND="dev-libs/openssl
	!<net-dns/dnssec-tools-1.13"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-respect-LDFLAGS.patch
}

src_configure() {
	econf \
		--with-nsec3 \
		--with-dlv
		$(use_with ipv6) \
		$(use_with threads)
}

src_install() {
	dodir /usr/bin /usr/include/validator
	default

	insinto /etc/dnssec-tools
	doins etc/{{dnsval,resolv}.conf,root.hints}
}
