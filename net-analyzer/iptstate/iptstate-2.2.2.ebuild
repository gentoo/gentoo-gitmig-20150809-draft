# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/iptstate/iptstate-2.2.2.ebuild,v 1.1 2010/07/26 22:29:25 jer Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="IP Tables State displays states being kept by iptables in a top-like format"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.phildev.net/iptstate/"

DEPEND="sys-libs/ncurses
	>=net-libs/libnetfilter_conntrack-0.0.50"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

src_prepare() {
	sed -i Makefile \
		-e 's|$(CXXFLAGS)|& $(LDFLAGS)|g' \
		|| die "sed failed"
}

src_compile() {
	emake CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	make PREFIX="${D}"/usr install || die
	dodoc README Changelog BUGS CONTRIB WISHLIST
}
