# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/dnsproxy/dnsproxy-1.16-r1.ebuild,v 1.3 2011/12/21 09:03:23 phajdan.jr Exp $

EAPI="2"

inherit eutils flag-o-matic

DESCRIPTION="The dnsproxy daemon is a proxy for DNS queries"
HOMEPAGE="http://www.wolfermann.org/dnsproxy.html"
SRC_URI="http://www.wolfermann.org/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="dev-libs/libevent"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-include.patch
	append-flags -D_GNU_SOURCE
}

src_compile() {
	emake dnsproxy || die "make failed"
}

src_install() {
	dosbin dnsproxy
	keepdir /var/empty

	newconfd "${FILESDIR}"/dnsproxy.confd dnsproxy
	newinitd "${FILESDIR}"/dnsproxy.initd dnsproxy
	insinto /etc/dnsproxy
	newins dnsproxy.conf dnsproxy.conf.dist

	dodoc README
	doman dnsproxy.1
}
