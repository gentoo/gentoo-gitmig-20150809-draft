# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipv6calc/ipv6calc-0.51.ebuild,v 1.1 2006/12/09 13:03:17 masterdriverz Exp $

inherit fixheadtails

DESCRIPTION="IPv6 address calculator"
HOMEPAGE="http://www.deepspace6.net/projects/ipv6calc.html"
SRC_URI="ftp://ftp.bieringer.de/pub/linux/IPv6/ipv6calc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"

IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}

	ht_fix_file ${S}/configure
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make root="${D}" install || die "make install failed"

	dodoc ChangeLog CREDITS README TODO USAGE
}
