# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libplist/libplist-1.3.ebuild,v 1.5 2010/07/23 18:11:42 ssuominen Exp $

EAPI=2
inherit cmake-utils eutils multilib python

DESCRIPTION="Support library to deal with Apple Property Lists (Binary & XML)"
HOMEPAGE="http://libimobiledevice.org/"
SRC_URI="http://cloud.github.com/downloads/JonathanBeck/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""
RESTRICT="test"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-lang/swig"

src_prepare() {
	sed -e 's:-Werror::g' \
		-i swig/CMakeLists.txt || die "sed failed"
}

src_configure() {
	mycmakeargs="-DCMAKE_SKIP_RPATH=ON
		-DCMAKE_INSTALL_LIBDIR=$(get_libdir)
		-DPYTHON_VERSION=$(python_get_version) VERBOSE=1
	"
	cmake-utils_src_configure
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/plist
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/plist
}
