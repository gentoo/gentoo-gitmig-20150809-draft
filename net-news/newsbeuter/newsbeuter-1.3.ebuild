# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/newsbeuter/newsbeuter-1.3.ebuild,v 1.1 2008/12/19 00:33:59 gentoofan23 Exp $

EAPI="1"
inherit toolchain-funcs eutils

DESCRIPTION="A RSS/Atom feed reader for the text console."
HOMEPAGE="http://www.newsbeuter.org/index.html"
SRC_URI="http://www.${PN}.org/downloads/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=">=dev-db/sqlite-3.5:3
		>=dev-libs/stfl-0.19
		net-misc/curl"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	test? ( dev-libs/boost )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:-ggdb:${CXXFLAGS}:" \
		-e "s:^CXX=.*:CXX=$(tc-getCXX):" \
		Makefile
}

src_compile() {
	emake prefix="/usr" || die
}

src_test() {
	emake test || die "Compiling testsuite failed"
	##Tests fail if in ${S} rather than in ${S}/test
	cd "${S}"/test
	./test || die "Testsuite failed"
}

src_install() {
	emake prefix="${D}/usr" install || die
	dodoc AUTHORS README
	mv "${D}"/usr/share/doc/${PN}/* "${D}"/usr/share/doc/${PF}/
	rm -rf "${D}"/usr/share/doc/${PN}
}
