# Copyright 1999-2005 Gentoo Foundation, Copyright 2003 The Hackers Choice - http://www.thc.org
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thcrut/thcrut-1.2.5.ebuild,v 1.8 2005/07/19 16:36:32 dholm Exp $

inherit eutils

DESCRIPTION="Network discovery and fingerprinting tool"
HOMEPAGE="http://www.thc.org/thc-rut/"
SRC_URI="http://www.thc.org/thc-rut/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

DEPEND="virtual/libpcap
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf Libnet-1.0.2a
	epatch "${FILESDIR}"/${PV}-libnet.patch
}

src_install() {
	make install DESTDIR="${D}" || die "make install failed"
	dodoc ChangeLog FAQ README TODO thcrutlogo.txt
}
