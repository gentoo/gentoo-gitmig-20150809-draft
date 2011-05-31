# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glpng/glpng-1.45-r1.ebuild,v 1.8 2011/05/31 10:33:05 scarabeus Exp $

EAPI=4

inherit cmake-utils multilib

DESCRIPTION="An OpenGL png image library"
HOMEPAGE="http://www.fifi.org/doc/libglpng-dev/glpng.html"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	# fix libdir placement
	sed -i \
		-e "s:CMAKE_INSTALL_LIBDIR lib:CMAKE_INSTALL_LIBDIR $(get_libdir):g"\
		"${S}"/CMakeLists.txt || die "sed failed"
}
