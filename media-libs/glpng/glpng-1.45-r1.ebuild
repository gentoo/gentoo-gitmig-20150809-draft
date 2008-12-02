# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glpng/glpng-1.45-r1.ebuild,v 1.1 2008/12/02 13:54:49 scarabeus Exp $

inherit cmake-utils

DESCRIPTION="An OpenGL png image library"
HOMEPAGE="http://www.fifi.org/doc/libglpng-dev/glpng.html"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libpng
	sys-libs/zlib"
