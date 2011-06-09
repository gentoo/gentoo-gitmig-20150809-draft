# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/apitrace/apitrace-1.0.ebuild,v 1.1 2011/06/09 05:47:25 radhermit Exp $

EAPI=3

inherit cmake-utils eutils python

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

RDEPEND="media-libs/libpng
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	qt4? (
		>=x11-libs/qt-core-4.7:4
		>=x11-libs/qt-gui-4.7:4
		>=x11-libs/qt-webkit-4.7:4
		>=dev-libs/qjson-0.5
	)"
DEPEND="${RDEPEND}
	|| ( dev-lang/python:2.7 dev-lang/python:2.6 )"

pkg_setup() {
	python_set_active_version 2
}

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-automagic-qt.patch
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_enable qt4 GUI)
	)

	cmake-utils_src_configure
}

src_install() {
	dobin "${CMAKE_BUILD_DIR}"/{glretrace,tracedump} || die
	use qt4 && { dobin "${CMAKE_BUILD_DIR}"/qapitrace || die ; }
	dolib.so "${CMAKE_BUILD_DIR}"/glxtrace.so || die

	dodoc README TODO || die

	exeinto /usr/share/${PN}/scripts
	doexe scripts/* || die
}
