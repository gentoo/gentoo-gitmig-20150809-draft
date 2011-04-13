# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libbulletml/libbulletml-0.0.6.ebuild,v 1.7 2011/04/13 14:34:06 tupone Exp $
EAPI=2

inherit eutils

DESCRIPTION="A Library of Bullet Markup Language"
HOMEPAGE="http://user.ecc.u-tokyo.ac.jp/~s31552/wp/libbulletml/index_en.html"
SRC_URI="http://user.ecc.u-tokyo.ac.jp/~s31552/wp/libbulletml/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/boost"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN#lib}/src"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc43.patch
	rm -r boost || die "remove of local boost failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dolib.a libbulletml.a || die "dolib.a failed"

	insinto /usr/include/bulletml
	doins *.h || die "doins .h failed"

	insinto /usr/include/bulletml/tinyxml
	doins tinyxml/tinyxml.h || die "doins tinyxml.h failed"

	insinto /usr/include/bulletml/ygg
	doins ygg/ygg.h || die "doins ygg.h failed"

	dodoc ../README*
}
