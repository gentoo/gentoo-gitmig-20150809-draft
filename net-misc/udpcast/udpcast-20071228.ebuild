# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/udpcast/udpcast-20071228.ebuild,v 1.1 2008/03/30 21:35:52 cedk Exp $

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
