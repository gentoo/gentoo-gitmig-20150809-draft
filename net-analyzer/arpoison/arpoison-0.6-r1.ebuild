# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpoison/arpoison-0.6-r1.ebuild,v 1.1 2010/09/18 23:54:35 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="A utility to poison ARP caches"
HOMEPAGE="http://arpoison.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=net-libs/libnet-1.1.0"
DEPEND="${RDEPEND}
		>=sys-apps/sed-4"

S="${WORKDIR}/${PN}"

src_prepare() {
	sed -i Makefile \
		-e 's|gcc \(-Wall\)|$(CC) \1 $(CFLAGS) $(LDFLAGS)|' \
		|| die "sed Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dosbin arpoison
	doman arpoison.8
	dodoc README TODO
}
