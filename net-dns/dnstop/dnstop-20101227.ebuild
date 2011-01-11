# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnstop/dnstop-20101227.ebuild,v 1.1 2011/01/11 22:44:53 rajiv Exp $

EAPI=2
inherit eutils

DESCRIPTION="Displays various tables of DNS traffic on your network."
HOMEPAGE="http://dnstop.measurement-factory.com/"
SRC_URI="http://dnstop.measurement-factory.com/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="ipv6"

RDEPEND="sys-libs/ncurses
	virtual/libpcap"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/dnstop-20090128-make-382.patch
}

src_configure() {
	econf \
		$(use_enable ipv6)
}

src_install() {
	dobin dnstop || die
	doman dnstop.8
	dodoc CHANGES
}
