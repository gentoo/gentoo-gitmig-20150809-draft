# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm/libprojectm-1.1.ebuild,v 1.1 2008/05/19 16:46:29 drac Exp $

inherit cmake-utils

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
	media-libs/mesa
	media-libs/glew
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/cmake"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix install problems.
	sed -e "s:@CMAKE_INSTALL_PREFIX@:/usr:g" < config.inp.in > config.inp
	sed -e "s:DESTINATION lib:DESTINATION $(get_libdir):" -i CMakeLists.txt
}
