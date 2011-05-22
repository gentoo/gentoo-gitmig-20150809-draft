# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-1.4.ebuild,v 1.4 2011/05/22 16:33:43 fauli Exp $

EAPI=3
PYTHON_DEPEND="python? 2:2.6"
inherit cmake-utils eutils multilib python

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE="python"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )"

RESTRICT="test"

DOCS="AUTHORS NEWS README"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	sed -i -e 's:-Werror::' swig/CMakeLists.txt || die
	epatch "${FILESDIR}"/${P}-gcc46.patch
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_SKIP_RPATH=ON
		$(cmake-utils_use_enable python)
		)

	cmake-utils_src_configure
}

pkg_postinst() {
	use python && python_mod_optimize plist
}

pkg_postrm() {
	use python && python_mod_cleanup plist
}
