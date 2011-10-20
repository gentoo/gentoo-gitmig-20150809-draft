# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imageworsener/imageworsener-0.9.5.ebuild,v 1.1 2011/10/20 00:47:21 sping Exp $

EAPI="2"

CMAKE_IN_SOURCE_BUILD=1
CMAKE_VERBOSE=1
inherit eutils cmake-utils

MY_P="${PN}-src-${PV}"
MY_PN="imagew"

DESCRIPTION="Utility for image scaling and processing"
HOMEPAGE="http://entropymine.com/imageworsener/"
SRC_URI="http://entropymine.com/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"  # TODO webp

DEPEND="media-libs/libpng:0
	virtual/jpeg"
	# TODO webp? ( >=media-libs/libwebp-0.1.3 )
	# TODO test? ( >=media-libs/libwebp-0.1.3 )
RDEPEND="${DEPEND}"

src_prepare() {
	# TODO bring back webp tests
	epatch "${FILESDIR}"/${P}-webp.patch \
			"${FILESDIR}"/${P}-disable-webp-tests.patch
}

src_configure() {
	mycmakeargs=( -DIW_SUPPORT_WEBP=0 )
	cmake-utils_src_configure
}

src_install() {
	dobin ${MY_PN} || die "dobin failed."
	dodoc readme.txt technical.txt changelog.txt || die
}

src_test() {
	cd "${S}/tests" || die
	./runtest "${S}/${MY_PN}"
}
