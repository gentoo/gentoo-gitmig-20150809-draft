# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/newsbeuter/newsbeuter-0.7-r1.ebuild,v 1.1 2008/01/27 14:13:11 ticho Exp $

inherit toolchain-funcs eutils

DESCRIPTION="A RSS/Atom feed reader for the text console."
HOMEPAGE="http://synflood.at/newsbeuter.html"
SRC_URI="http://synflood.at/${PN}/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=net-libs/libnxml-0.18
		>=net-libs/libmrss-0.18
		=dev-db/sqlite-3*
		>=dev-libs/stfl-0.14
		net-misc/curl"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	if has_version ">=dev-db/sqlite-3.5" ; then
		epatch "${FILESDIR}"/${PV}-sqlite-3.5.patch || die
	fi

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
