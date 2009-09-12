# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20090830.ebuild,v 1.1 2009/09/12 09:08:30 patrick Exp $

DESCRIPTION="Multicast file transfer tool"
HOMEPAGE="http://udpcast.linux.lu/"
SRC_URI="http://udpcast.linux.lu/download/${P}.tar.bz2"

IUSE=""
LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/^override LDFLAGS +=-s//" \
		Makefile.in
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc *.txt
}
