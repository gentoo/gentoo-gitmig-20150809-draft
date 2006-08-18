# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/btpd/btpd-0.11.ebuild,v 1.1 2006/08/18 01:23:09 metalgod Exp $

DESCRIPTION="BTPD is a bittorrent client consisting of a daemon and client commands"
HOMEPAGE="http://www.murmeldjur.se/btpd/"
SRC_URI="http://www.murmeldjur.se/btpd/${P}.tar.gz http://people.su.se/~rnyberg/btpd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="net-misc/curl
		dev-libs/openssl
		dev-libs/libevent"
DEPEND="${RDEPEND}"

src_compile() {
	econf || die "econf failed"
	emake || die "econf failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc CHANGES COPYRIGHT README
}
