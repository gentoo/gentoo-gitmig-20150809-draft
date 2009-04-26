# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync/libopensync-0.38.ebuild,v 1.1 2009/04/26 20:51:40 patrick Exp $

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
	python? ( >=dev-lang/python-2.2 )"

DEPEND="${RDEPEND}
	python? ( >=dev-lang/swig-1.3.17 )
	>=dev-util/cmake-2.4.7
	>=dev-util/pkgconfig-0.9.0
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack $A
	cd $PN-$PV
	epatch "$FILESDIR/libopensync-py2.6.patch"
}

src_compile() {
	local mycmakeargs
	mycmakeargs="${mycmakeargs} -DCMAKE_SKIP_RPATH=ON"
	mycmakeargs="${mycmakeargs} -DOPENSYNC_TRACE=$(use debug && echo ON || echo OFF)"
	mycmakeargs="${mycmakeargs} -DOPENSYNC_DEBUG_MODULES=$(use debug && echo ON || echo OFF)"
	mycmakeargs="${mycmakeargs} -DOPENSYNC_PYTHONBINDINGS=$(use python && echo ON || echo OFF)"
	mycmakeargs="${mycmakeargs} -DBUILD_DOCUMENTATION=$(use doc && echo ON || echo OFF)"
	cmake-utils_src_compile

	if use doc ; then
		cd "${WORKDIR}/${PN}_build"
		doxygen Doxyfile || die "Failed to generate docs."
	fi
}

src_test() {
	echo ">>> Test phase [test]: ${CATEGORY}/${PF}"

	pushd "${WORKDIR}/${PN}_build" > /dev/null

	if ! LD_LIBRARY_PATH="${WORKDIR}/${PN}_build/opensync/" emake -j1 test ; then
		die "Make test failed. See above for details."
	fi

	popd > /dev/null
}

src_install() {
	cmake-utils_src_install

	if use doc ; then
		cd "${WORKDIR}/${PN}_build"
		dohtml docs/html/* || die "Failed to install docs."
	fi
}

pkg_postinst() {
	elog "Building with 'debug' useflag is highly encouraged"
	elog "and requiered for bug reports."
	elog "Also see http://www.opensync.org/wiki/tracing"
}
