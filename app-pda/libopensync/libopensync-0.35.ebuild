# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-0.35.ebuild,v 1.3 2009/06/05 11:42:55 scarabeus Exp $

inherit cmake-utils eutils

DESCRIPTION="OpenSync synchronisation framework library"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://www.opensync.org/download/releases/${PV}/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE="debug doc python"

# Tests don't pass
#>=dev-libs/check-0.9.2
#mycmakeargs="${mycmakeargs} -DOPENSYNC_UNITTESTS=ON"
RESTRICT="test"

RDEPEND=">=dev-db/sqlite-3
	>=dev-libs/glib-2
	dev-libs/libxml2
	python? ( >=dev-lang/python-2.2 >=dev-lang/swig-1.3.17 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	doc? ( app-doc/doxygen )"

src_compile() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs} -DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use debug OPENSYNC_TRACE)
		$(cmake-utils_use debug OPENSYNC_DEBUG_MODULES)
		$(cmake-utils_use python OPENSYNC_PYTHONBINDINGS)
		$(cmake-utils_use_build doc DOCUMENTATION)
	"
	cmake-utils_src_compile

	if use doc ; then
		cd "${CMAKE_BUILD_DIR}"
		doxygen Doxyfile || die "Failed to generate docs."
	fi
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		cd "${CMAKE_BUILD_DIR}"
		dohtml docs/html/* || die "Failed to install docs."
	fi
}

pkg_postinst() {
	elog "Building with 'debug' useflag is highly encouraged"
	elog "and requiered for bug reports."
	elog "Also see http://www.opensync.org/wiki/tracing"
}
