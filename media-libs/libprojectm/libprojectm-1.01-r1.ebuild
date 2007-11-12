# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm/libprojectm-1.01-r1.ebuild,v 1.2 2007/11/12 04:31:43 drac Exp $

inherit eutils toolchain-funcs

MY_P=${P/m/M}

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="media-libs/ftgl
	media-libs/freetype
	media-libs/glew
	virtual/opengl
	media-libs/glew
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-malloc.patch
	epatch "${FILESDIR}"/${P}-soil_64bit_fixes.patch
	epatch "${FILESDIR}"/${P}-cmake_soname.patch

	sed -e "s#/lib/pkgconfig#/$(get_libdir)/pkgconfig#" \
		-e "s#DESTINATION lib#DESTINATION $(get_libdir)#" \
		-i CMakeLists.txt
}

src_compile() {
	cmake \
		-DCMAKE_VERBOSE_MAKEFILE="ON" \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		-DCMAKE_C_COMPILER="$(type -P $(tc-getCC))" \
		-DCMAKE_CXX_COMPILER="$(type -P $(tc-getCXX))" \
		-DCMAKE_C_FLAGS="${CFLAGS}" \
		-DCMAKE_CXX_FLAGS="${CXXFLAGS}" \
		-DCMAKE_LD_FLAGS="${LDFLAGS}" \
		. || die "cmake failed."

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
}
