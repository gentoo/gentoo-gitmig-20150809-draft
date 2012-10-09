# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpoison/arpoison-0.6.ebuild,v 1.10 2012/10/09 07:57:16 pinkbyte Exp $

inherit toolchain-funcs

DESCRIPTION="A utility to poison ARP caches"
HOMEPAGE="http://arpoison.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=">=net-libs/libnet-1.1.0"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4"

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
