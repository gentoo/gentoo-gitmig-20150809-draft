# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glpng/glpng-1.45-r1.ebuild,v 1.3 2009/01/29 14:13:29 scarabeus Exp $

inherit cmake-utils multilib

DESCRIPTION="An OpenGL png image library"
HOMEPAGE="http://www.fifi.org/doc/libglpng-dev/glpng.html"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="virtual/opengl
	media-libs/libpng
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=dev-util/cmake-2.6.1"

src_unpack() {
	unpack ${A}
	# fix libdir placement
	sed -i \
		-e "s:CMAKE_INSTALL_LIBDIR lib:CMAKE_INSTALL_LIBDIR $(get_libdir):g"\
		"${S}"/CMakeLists.txt || die "sed failed"
}
