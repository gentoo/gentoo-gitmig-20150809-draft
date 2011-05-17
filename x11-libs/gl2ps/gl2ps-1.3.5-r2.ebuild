# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gl2ps/gl2ps-1.3.5-r2.ebuild,v 1.2 2011/05/17 09:53:51 jlec Exp $

EAPI=3
inherit cmake-utils multilib

DESCRIPTION="OpenGL to PostScript printing library"
HOMEPAGE="http://www.geuz.org/gl2ps/"
SRC_URI="http://geuz.org/${PN}/src/${P}.tgz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc png zlib"

DEPEND="
	media-libs/freeglut
	png? ( media-libs/libpng )
	doc? ( dev-tex/tth dev-texlive/texlive-latex )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}-source

PATCHES=(
	"${FILESDIR}"/${P}-CMakeLists.patch
	"${FILESDIR}"/${P}-soversion.patch )

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable png PNG)
		$(cmake-utils_use_enable zlib ZLIB)
		$(cmake-utils_use_enable doc DOC)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libgl2ps.dylib \
			"${D%/}${EPREFIX}"/usr/$(get_libdir)/libgl2ps.dylib || die
	fi
}
