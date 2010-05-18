# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libproxy/libproxy-0.4.1.ebuild,v 1.1 2010/05/18 16:52:08 tester Exp $

EAPI="2"
CMAKE_MIN_VERSION="2.8"

inherit cmake-utils eutils python portability

DESCRIPTION="Library for automatic proxy configuration management"
HOMEPAGE="http://code.google.com/p/libproxy/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug gnome kde networkmanager perl python vala webkit xulrunner"

RDEPEND="
	gnome? ( gnome-base/gconf )
	kde? ( >=kde-base/kdelibs-4.3 )
	networkmanager? ( net-misc/networkmanager )
	perl? (	dev-lang/perl )
	python? ( >=dev-lang/python-2.5 )
	vala? ( dev-lang/vala )
	webkit? ( net-libs/webkit-gtk )
	xulrunner? ( >=net-libs/xulrunner-1.9.0.11-r1:1.9 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19"

DOCS="AUTHORS NEWS README ChangeLog"

src_prepare() {
	base_src_prepare
	if use debug; then
	  sed "s/-g -Wall -Werror /-g -Wall /" CMakeLists.txt -i
	else
	  sed "s/-g -Wall -Werror / /" CMakeLists.txt -i
	fi
}

src_configure() {
	mycmakeargs=(
			-DCMAKE_CXX_FLAGS="${CXXFLAGS}"
			-DCMAKE_LD_FLAGS="${CXXFLAGS}"
			$(cmake-utils_use_with gnome GNOME)
			$(cmake-utils_use_with kde KDE4)
			$(cmake-utils_use_with networkmanager NM)
			$(cmake-utils_use_with perl PERL)
			$(cmake-utils_use_with python PYTHON)
			$(cmake-utils_use_with vala VALA)
			$(cmake-utils_use_with webkit WEBKIT)
			$(cmake-utils_use_with xulrunner MOZJS)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	if use python; then
		python_need_rebuild
		python_mod_optimize "$(python_get_sitedir)/${PN}.py"
	fi
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/${PN}.py
}
