# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/glpng/glpng-1.45.ebuild,v 1.1 2008/11/28 19:57:34 scarabeus Exp $

inherit eutils

DESCRIPTION="An OpenGL png image library"
HOMEPAGE="http://www.fifi.org/doc/libglpng-dev/glpng.html"
SRC_URI="http://www.amdmi3.ru/distfiles/${PN}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/libpng"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cp "${FILESDIR}"/Makefile "${S}"/Makefile
	sed -i \
		-e "s:\"png/png.h\":<png.h>:" \
		"${S}"/src/glpng.c || die "sed glpng.c failed"
	sed -i \
		-e "s:/src:${S}/src:" \
		"${S}"/Makefile || die "sed Makefile failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
}
