# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nessus-libraries/nessus-libraries-2.2.9-r1.ebuild,v 1.1 2011/04/20 07:17:11 jlec Exp $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="A remote security scanner for Linux (nessus-libraries)"
HOMEPAGE="http://www.nessus.org/"
SRC_URI="ftp://ftp.nessus.org/pub/nessus/nessus-${PV}/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="crypt debug static-libs"

# Hard dep on SSL since libnasl won't compile when this package is emerged -ssl.
DEPEND="
	dev-libs/openssl
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-linking.patch
	sed \
		-e "s:^\(LDFLAGS=\):\1 ${LDFLAGS}:g" \
		-i nessus.tmpl.in
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable crypt cypher) \
		$(use_enable debug) \
		$(use_enable debug debug-ssl) \
		$(use_enable static-libs static) \
		--enable-shared \
		--with-ssl="${EPREFIX}/usr/$(get_libdir)" \
		--disable-nessuspcap
}
