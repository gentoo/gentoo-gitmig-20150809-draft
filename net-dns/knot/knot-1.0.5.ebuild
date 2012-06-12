# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/knot/knot-1.0.5.ebuild,v 1.1 2012/06/12 14:54:00 scarabeus Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="High-performance authoritative-only DNS server"
HOMEPAGE="http://www.knot-dns.cz/"
SRC_URI="http://public.nic.cz/files/knot-dns/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	dev-libs/openssl
	dev-libs/userspace-rcu
"
#	sys-libs/glibc
DEPEND="${RDEPEND}
	virtual/pkgconfig
	sys-devel/flex
	virtual/yacc
"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-move-pidfile-to-var.patch \
		"${FILESDIR}"/${PN}-braindead-lto.patch
	sed -i \
		-e 's:-Werror::g' \
		configure.ac || die
	eautoreconf
}

src_configure() {
	econf \
		--sysconfdir="${EPREFIX}/etc/${PN}" \
		--libexecdir="${EPREFIX}/usr/libexec/${PN}" \
		--enable-recvmmsg \
		$(use_enable debug debug verbose)
}

src_install() {
	default

	newinitd "${FILESDIR}/knot.init" knot-dns
}
