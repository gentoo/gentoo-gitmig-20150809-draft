# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-1.8.ebuild,v 1.1 2012/02/10 21:07:28 pesa Exp $

EAPI=4

inherit cmake-utils python

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE="cython python"

RDEPEND="dev-libs/libxml2
	cython? ( =dev-lang/python-2* )
	python? ( =dev-lang/python-2* )
"
DEPEND="${RDEPEND}
	cython? ( dev-python/cython )
	python? ( dev-lang/swig )
"

DOCS=(AUTHORS NEWS README)

pkg_setup() {
	if use cython || use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i -e 's:-Werror::' swig/CMakeLists.txt || die
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use_enable cython)
		$(cmake-utils_use_enable python SWIG)
	)

	cmake-utils_src_configure
}

src_test() {
	cd "${CMAKE_BUILD_DIR}"

	local testfile
	for testfile in "${S}"/test/data/*; do
		LD_LIBRARY_PATH=src ./test/plist_test "${testfile}" || die
	done
}

pkg_postinst() {
	use python && python_mod_optimize plist
}

pkg_postrm() {
	use python && python_mod_cleanup plist
}
