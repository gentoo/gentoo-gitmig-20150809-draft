# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ipv6calc/ipv6calc-0.72.0.ebuild,v 1.2 2008/12/28 20:30:14 pva Exp $

inherit eutils fixheadtails toolchain-funcs autotools

DESCRIPTION="IPv6 address calculator"
HOMEPAGE="http://www.deepspace6.net/projects/ipv6calc.html"
SRC_URI="ftp://ftp.bieringer.de/pub/linux/IPv6/ipv6calc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="geoip"

DEPEND="geoip? ( >=dev-libs/geoip-1.4.1 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find \( -name Makefile.in -o -name Makefile \) -exec \
		sed -e "s:\(^CC[[:space:]]=\).*:\1 $(tc-getCC):" \
			-e "s:\(^LDFLAGS[[:space:]]=.*\)$:\1 ${LDFLAGS}:" \
			-e "/^CFLAGS/{s:-I\$(GETOPT_DIR)::}" \
			-e "s:\(^CFLAGS[[:space:]]=.*\):\1 ${CFLAGS}:" \
				-i '{}' \;
	epatch "${FILESDIR}/${P}-optional-geoip.patch"
	eautoreconf
	ht_fix_file configure
}

src_compile() {
	econf $(use_enable geoip)
	emake || die "emake failed"
}

src_install() {
	make root="${D}" install || die "make install failed"
	dodoc ChangeLog CREDITS README TODO USAGE || die
}
