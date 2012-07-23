# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/glog/glog-0.3.2.ebuild,v 1.2 2012/07/23 21:04:46 maekke Exp $

EAPI="4"
inherit eutils

DESCRIPTION="Google's C++ logging library"
HOMEPAGE="http://code.google.com/p/google-glog/"
SRC_URI="http://google-glog.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="gflags static-libs unwind test"

RDEPEND="gflags? ( dev-cpp/gflags )
	unwind? ( sys-libs/libunwind )"
DEPEND="${RDEPEND}
	test? (
		dev-cpp/gmock
		dev-cpp/gtest
	)"

src_configure() {
	export ac_cv_lib_gflags_main=$(usex gflags)
	export ac_cv_lib_unwind_backtrace=$(usex unwind)
	use test || export ac_cv_prog_GTEST_CONFIG=no
	econf $(use_enable static-libs static)
}

src_install() {
	default

	rm -rf "${D}/usr/share/doc"
	dodoc AUTHORS ChangeLog NEWS README*
	dohtml doc/*

	use static-libs || rm "${D}"/usr/lib*/*.la
}
