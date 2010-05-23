# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-0.39.ebuild,v 1.3 2010/05/23 20:38:01 bangert Exp $

inherit cmake-utils

DESCRIPTION="OpenSync synchronisation framework library"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="doc python test"

# 14% tests passed, 275 tests failed out of 321
RESTRICT="test"

RDEPEND=">=dev-db/sqlite-3
	>=dev-libs/glib-2.12
	dev-libs/libxml2
	python? ( >=dev-lang/python-2.2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	doc? ( app-doc/doxygen )
	python? ( >=dev-lang/swig-1.3.17 )
	test? ( >=dev-libs/check-0.9.2 )"

src_compile() {
	DOCS="AUTHORS CODING ChangeLog README"

	local mycmakeargs="
		-DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use_enable python WRAPPER)
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use test OPENSYNC_UNITTESTS)
	"

	cmake-utils_src_compile

	if use doc ; then
		cmake-utils_src_make DoxygenDoc || die "Failed to generate docs."
	fi
}

src_test() {
	pushd "${CMAKE_BUILD_DIR}" > /dev/null

	if ! LD_LIBRARY_PATH="${CMAKE_BUILD_DIR}/opensync/" emake -j1 test ; then
		die "Make test failed. See above for details."
	fi

	popd > /dev/null
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		cd "${CMAKE_BUILD_DIR}"
		dohtml docs/html/* || die "Failed to install docs."
	fi
}

pkg_postinst() {
	einfo "For >=app-pda/libopensync-0.39 use app-pda/osynctool instead of"
	einfo "the older app-pda/msynctool."
}
