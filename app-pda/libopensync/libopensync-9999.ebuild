# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-9999.ebuild,v 1.1 2007/11/26 20:12:07 peper Exp $

inherit cmake-utils eutils subversion

DESCRIPTION="OpenSync synchronisation framework library"
HOMEPAGE="http://www.opensync.org/"
SRC_URI=""

ESVN_REPO_URI="http://svn.opensync.org/trunk"

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
	mycmakeargs="${mycmakeargs} -DCMAKE_SKIP_RPATH=ON"
	mycmakeargs="${mycmakeargs} -DOPENSYNC_TRACE=$(use debug && echo ON || echo OFF)"
	mycmakeargs="${mycmakeargs} -DOPENSYNC_DEBUG_MODULES=$(use debug && echo ON || echo OFF)"
	mycmakeargs="${mycmakeargs} -DOPENSYNC_PYTHONBINDINGS=$(use python && echo ON || echo OFF)"
	mycmakeargs="${mycmakeargs} -DBUILD_DOCUMENTATION=$(use doc && echo ON || echo OFF)"
	cmake-utils_src_compile

	use doc && doxygen Doxyfile
}

src_install() {
	cmake-utils_src_install

	use doc && dohtml docs/html/*
}

pkg_postinst() {
	elog "Building with 'debug' useflag is highly encouraged"
	elog "and requiered for bug reports."
	elog "Also see http://www.opensync.org/wiki/tracing"
}
