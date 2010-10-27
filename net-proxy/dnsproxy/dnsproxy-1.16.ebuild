# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/dnsproxy/dnsproxy-1.16.ebuild,v 1.4 2010/10/27 14:27:52 hwoarang Exp $

DESCRIPTION="The dnsproxy daemon is a proxy for DNS queries"
HOMEPAGE="http://www.wolfermann.org/dnsproxy.html"
SRC_URI="http://www.wolfermann.org/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-libs/libevent"

src_compile() {
	econf --with-native-libevent || die "econf failed"
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
