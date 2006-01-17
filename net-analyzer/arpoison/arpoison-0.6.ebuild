# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpoison/arpoison-0.6.ebuild,v 1.5 2006/01/17 15:03:58 nixnut Exp $

inherit toolchain-funcs

DESCRIPTION="A utility to poision ARP caches"
HOMEPAGE="http://arpoison.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND="virtual/libc
	>=net-libs/libnet-1.1.0"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "s|\(-Wall\)|\1 ${CFLAGS}|" \
		-e "s|gcc|$(tc-getCC)|" Makefile || die "sed Makefile failed"
}

src_install() {
	dosbin arpoison
	doman arpoison.8
	dodoc README TODO
}
