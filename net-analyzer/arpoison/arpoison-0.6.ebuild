# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpoison/arpoison-0.6.ebuild,v 1.2 2005/02/03 16:35:37 ka0ttic Exp $

inherit toolchain-funcs

DESCRIPTION="A utility to poision ARP caches"
HOMEPAGE="http://arpoison.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
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
