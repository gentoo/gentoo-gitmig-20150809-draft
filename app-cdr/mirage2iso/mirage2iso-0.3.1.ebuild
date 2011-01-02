# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/mirage2iso/mirage2iso-0.3.1.ebuild,v 1.2 2011/01/02 21:31:39 mr_bones_ Exp $

EAPI=2

inherit autotools-utils versionator

TESTS_PV=$(get_version_component_range 1-2)

DESCRIPTION="CD/DVD image converter using libmirage"
HOMEPAGE="https://github.com/mgorny/mirage2iso/"
SRC_URI="http://cloud.github.com/downloads/mgorny/${PN}/${P}.tar.bz2
	test? ( http://cloud.github.com/downloads/mgorny/${PN}/${PN}-${TESTS_PV}-tests.tar.xz )"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pinentry test"

COMMON_DEPEND="dev-libs/libmirage
	dev-libs/glib:2
	pinentry? ( dev-libs/libassuan )"
DEPEND="${COMMON_DEPEND}
	test? ( app-arch/xz-utils )"
RDEPEND="${COMMON_DEPEND}
	pinentry? ( app-crypt/pinentry )"

DOCS=( NEWS README )

src_configure() {
	myeconfargs=(
		$(use_with pinentry libassuan)
	)

	autotools-utils_src_configure
}

src_test() {
	xz -cd "${DISTDIR}"/${PN}-${TESTS_PV}-tests.tar.xz | \
		tar -x --strip-components 1 || die

	autotools-utils_src_test
}
