# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/rsstail/rsstail-1.3.ebuild,v 1.2 2008/05/21 23:06:11 rbu Exp $

inherit toolchain-funcs

DESCRIPTION="A tail-like RSS-reader"
HOMEPAGE="http://www.vanheusden.com/rsstail/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=net-libs/libmrss-0.17.1"
RDEPEND="${DEPEND}"

src_compile() {
	emake \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS} -DVERSION=\\\"\$(VERSION)\\\"" \
		LDFLAGS="${LDFLAGS} -lmrss" \
		|| die "emake failed"
}

src_install() {
	dobin rsstail || die "dobin failed"
	doman rsstail.1 || die "doman failed"
	newdoc readme.txt README || die "installing docs failed"
}
