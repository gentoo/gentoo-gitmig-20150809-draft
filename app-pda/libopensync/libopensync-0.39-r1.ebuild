# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-0.39-r1.ebuild,v 1.1 2011/02/12 03:51:19 dirtyepic Exp $

EAPI="3"

PYTHON_DEPEND="python? 2:2.5"
SUPPORT_PYTHON_ABIS="1"

inherit cmake-utils python

DESCRIPTION="OpenSync synchronisation framework library"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="doc python" # test

RDEPEND="dev-db/sqlite:3
	>=dev-libs/glib-2.12:2
	dev-libs/libxml2
	dev-libs/libxslt"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	doc?	( app-doc/doxygen
			  media-gfx/graphviz )
	python?	( >=dev-lang/swig-1.3.17 )"
#	test?	( >=dev-libs/check-0.9.2 )"

# 14% tests passed, 275 tests failed out of 321
RESTRICT="test"

DOCS="AUTHORS CODING ChangeLog README"

RESTRICT_PYTHON_ABIS="3.*"

#CMAKE_VERBOSE="1"

src_prepare() {
	# Has hardcoded python versions, use the module shipped with cmake instead
	# bug #276220
	rm "${S}"/cmake/modules/FindPythonLibs.cmake

	use python && python_copy_sources
}

src_configure() {
	local mycmakeargs="
		-DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use_build doc DOCUMENTATION)
		$(cmake-utils_use_enable python WRAPPER)
		$(cmake-utils_use python OPENSYNC_PYTHONBINDINGS)
		$(cmake-utils_use test OPENSYNC_UNITTESTS)"

	do_configure() {
		if use python; then
			CMAKE_BUILD_DIR="${WORKDIR}/${P}-${PYTHON_ABI}"
			CMAKE_USE_DIR="${CMAKE_BUILD_DIR}"
			# since we're using cmake's FindPythonLibs PYTHON_VERSION is
			# not defined
			sed -i -e "s:\${PYTHON_VERSION}:${PYTHON_ABI}:g" \
				"${CMAKE_BUILD_DIR}"/wrapper/CMakeLists.txt
		fi
		cmake-utils_src_configure || die
	}

	use python \
		&& python_execute_function -s do_configure \
		|| do_configure
}

src_compile() {
	do_compile() {
		if use python; then
			CMAKE_BUILD_DIR="${WORKDIR}/${P}-${PYTHON_ABI}"
			CMAKE_USE_DIR="${CMAKE_BUILD_DIR}"
		fi
		cmake-utils_src_compile || die
	}

	use python \
		&& python_execute_function -s do_compile \
		|| do_compile

	if use doc ; then
		cmake-utils_src_make DoxygenDoc || die
	fi
}

# TODO - fix
src_test() {
	pushd "${CMAKE_BUILD_DIR}" > /dev/null

	if ! LD_LIBRARY_PATH="${CMAKE_BUILD_DIR}/opensync/" emake -j1 test ; then
		die "Make test failed. See above for details."
	fi

	popd > /dev/null
}

src_install() {
	do_install() {
		if use python; then
			CMAKE_BUILD_DIR="${WORKDIR}/${P}-${PYTHON_ABI}"
			CMAKE_USE_DIR="${CMAKE_BUILD_DIR}"
		fi
		cmake-utils_src_install || die
	}

	use python \
		&& python_execute_function -s do_install \
		|| do_install

	if use doc; then
		cd "${CMAKE_BUILD_DIR}"
		dohtml docs/html/* || die
	fi
}

pkg_postinst() {
	einfo "For >=app-pda/libopensync-0.39 use app-pda/osynctool instead of"
	einfo "the older app-pda/msynctool."
}
