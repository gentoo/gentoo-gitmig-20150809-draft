# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/newsbeuter/newsbeuter-0.4.ebuild,v 1.1 2007/05/10 12:20:50 ticho Exp $

inherit toolchain-funcs

DESCRIPTION="A RSS feed reader for the text console."
HOMEPAGE="http://synflood.at/newsbeuter.html"
SRC_URI="http://synflood.at/${PN}/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-libs/libnxml
		net-libs/libmrss
		=dev-db/sqlite-3*
		dev-libs/stfl
		net-misc/curl"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i \
		-e "s:-ggdb:${CXXFLAGS}:" \
		-e "s:^CXX=.*:CXX=$(tc-getCXX):" \
		Makefile
}

src_compile() {
	emake prefix="/usr" || die
}

src_install() {
	make prefix="${D}/usr" install || die
	dodoc AUTHORS README
	mv "${D}"/usr/share/doc/${PN}/* "${D}"/usr/share/doc/${PF}/
	rm -rf "${D}"/usr/share/doc/${PN}
}
