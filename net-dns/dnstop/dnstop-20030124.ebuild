# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnstop/dnstop-20030124.ebuild,v 1.4 2005/01/29 21:19:18 dragonheart Exp $

DESCRIPTION="Displays various tables of DNS traffic on your network."
HOMEPAGE="http://dnstop.measurement-factory.com/"
SRC_URI="http://dnstop.measurement-factory.com/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc"

IUSE=""
DEPEND="virtual/libpcap"

S=${WORKDIR}

src_compile() {
	cp Makefile Makefile.orig
	sed -e "s:^CFLAGS=.*$:CFLAGS=${CFLAGS} -DUSE_PPP:" \
		Makefile.orig > Makefile

	emake || die
}

src_install() {
	dobin dnstop
	doman dnstop.8
	dodoc LICENSE
}
