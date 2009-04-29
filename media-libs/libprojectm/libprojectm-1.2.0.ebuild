# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm/libprojectm-1.2.0.ebuild,v 1.3 2009/04/29 19:47:44 maekke Exp $

inherit cmake-utils

MY_P=${P/m/M}

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
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
	if has_version ">=media-libs/ftgl-2.1.3_rc5"; then
		sed -i -e 's:FTGL.h:ftgl.h:g' "${S}"/Renderer.hpp || die "sed failed."
	fi
}
