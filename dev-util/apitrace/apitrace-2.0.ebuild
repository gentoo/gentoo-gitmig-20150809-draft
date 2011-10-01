# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/apitrace/apitrace-2.0.ebuild,v 1.1 2011/10/01 23:44:02 radhermit Exp $

EAPI="3"
PYTHON_DEPEND="2:2.6"

inherit cmake-utils eutils python multilib

DESCRIPTION="A tool for tracing, analyzing, and debugging graphics APIs"
HOMEPAGE="https://github.com/apitrace/apitrace"
SRC_URI="https://github.com/${PN}/${PN}/tarball/${PV} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="multilib qt4"

RDEPEND="app-arch/snappy
	media-libs/libpng
	sys-libs/zlib
	virtual/opengl
	x11-libs/libX11
	multilib? ( app-emulation/emul-linux-x86-baselibs )
	qt4? (
		>=x11-libs/qt-core-4.7:4
		>=x11-libs/qt-gui-4.7:4
		>=x11-libs/qt-webkit-4.7:4
		>=dev-libs/qjson-0.5
	)"
DEPEND="${RDEPEND}"

EMULTILIB_PKG="true"

pkg_setup() {
	python_set_active_version 2
}

src_unpack() {
	unpack ${A}
	mv *-${PN}-* "${S}"
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-system-libs.patch \
		"${FILESDIR}"/${P}-glxtrace-only.patch
}

src_configure() {
	for ABI in $(get_install_abis) ; do
		mycmakeargs=( $(cmake-utils_use_enable qt4 GUI) )

		if use multilib ; then
			if [[ "${ABI}" != "${DEFAULT_ABI}" ]] ; then
				mycmakeargs=( -DBUILD_LIB_ONLY=ON -DENABLE_GUI=OFF )
			fi
			multilib_toolchain_setup ${ABI}
		fi

		CMAKE_BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
		cmake-utils_src_configure
	done
}

src_compile() {
	for ABI in $(get_install_abis) ; do
		use multilib && multilib_toolchain_setup ${ABI}
		CMAKE_BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
		cmake-utils_src_compile
	done
}

src_install() {
	dobin "${CMAKE_BUILD_DIR}"/{glretrace,tracedump} || die
	use qt4 && { dobin "${CMAKE_BUILD_DIR}"/qapitrace || die ; }

	for ABI in $(get_install_abis) ; do
		CMAKE_BUILD_DIR="${WORKDIR}/${P}_build-${ABI}"
		dolib.so "${CMAKE_BUILD_DIR}"/glxtrace.so || die
	done

	dodoc {BUGS,NEWS,README,TODO}.markdown || die

	exeinto /usr/share/${PN}/scripts
	doexe scripts/* || die
}
