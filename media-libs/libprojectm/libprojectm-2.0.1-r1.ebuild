# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libprojectm/libprojectm-2.0.1-r1.ebuild,v 1.1 2009/12/22 13:22:35 aballier Exp $

EAPI=2
inherit cmake-utils flag-o-matic eutils

MY_P=${P/m/M}-Source ; MY_P=${MY_P/lib}

DESCRIPTION="A graphical music visualization plugin similar to milkdrop"
HOMEPAGE="http://projectm.sourceforge.net"
SRC_URI="mirror://sourceforge/projectm/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=media-libs/ftgl-2.1.3_rc5
	media-libs/freetype:2
	media-libs/mesa
	media-libs/glew
	sys-libs/zlib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${P}-pcfix.patch"
}

src_configure() {
	append-ldflags $(no-as-needed)
	cmake-utils_src_configure
}
