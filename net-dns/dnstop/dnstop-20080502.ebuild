# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnstop/dnstop-20080502.ebuild,v 1.4 2009/01/11 19:09:56 maekke Exp $

DESCRIPTION="Displays various tables of DNS traffic on your network."
HOMEPAGE="http://dnstop.measurement-factory.com/"
SRC_URI="http://dnstop.measurement-factory.com/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc sparc x86"

IUSE="ipv6"
DEPEND="sys-libs/ncurses
	virtual/libpcap"

src_compile() {
	econf $(use_enable ipv6) || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	dobin dnstop
	doman dnstop.8
	dodoc CHANGES
}
