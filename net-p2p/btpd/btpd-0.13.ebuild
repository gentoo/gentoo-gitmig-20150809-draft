# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/btpd/btpd-0.13.ebuild,v 1.1 2007/06/18 22:32:25 sekretarz Exp $

DESCRIPTION="BTPD is a bittorrent client consisting of a daemon and client commands"
HOMEPAGE="http://www.murmeldjur.se/btpd/"
SRC_URI="http://www.murmeldjur.se/btpd/${P}.tar.gz http://people.su.se/~rnyberg/btpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="net-misc/curl
		dev-libs/openssl
		dev-libs/libevent
		sys-apps/shadow"
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "econf failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	newinitd "${FILESDIR}/initd_btpd" btpd
	newconfd "${FILESDIR}/confd_btpd" btpd

	dodoc CHANGES COPYRIGHT README
}
