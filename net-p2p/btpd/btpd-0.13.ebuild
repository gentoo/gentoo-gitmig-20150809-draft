# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/btpd/btpd-0.13.ebuild,v 1.2 2007/09/11 11:35:22 armin76 Exp $

DESCRIPTION="BitTorrent client consisting of a daemon and client"
HOMEPAGE="http://www.murmeldjur.se/btpd/"
SRC_URI="http://www.murmeldjur.se/btpd/${P}.tar.gz http://people.su.se/~rnyberg/btpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
		dev-libs/openssl
		sys-apps/shadow"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/initd_btpd" btpd
	newconfd "${FILESDIR}/confd_btpd" btpd

	dodoc CHANGES COPYRIGHT README
}
