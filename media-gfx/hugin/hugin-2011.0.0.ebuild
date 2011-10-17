# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-2011.0.0.ebuild,v 1.5 2011/10/17 19:00:41 xarthisius Exp $

EAPI=4
WX_GTK_VER="2.8"

inherit wxwidgets versionator cmake-utils

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="amd64 ppc x86"

LANGS=" bg ca cs de en_GB es fi fr hu it ja ko nl pl pt_BR ro ru sk sl sv uk zh_CN zh_TW"
IUSE="lapack sift $(echo ${LANGS//\ /\ linguas_})"

CDEPEND="
	!!dev-util/cocom
	app-arch/zip
	>=dev-libs/boost-1.35.0-r5
	>=media-gfx/enblend-4.0
	media-gfx/exiv2
	media-libs/freeglut
	>=media-libs/libpano13-2.9.18
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sys-libs/zlib
	virtual/jpeg
	x11-libs/wxGTK:2.8[X,opengl,-odbc]
	lapack? ( virtual/lapack )
	sift? ( media-gfx/autopano-sift-C )"
RDEPEND="${CDEPEND}
	media-libs/exiftool"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

PATCHES=( "${FILESDIR}"/${P}_rc1-libpng15.patch )

pkg_setup() {
	DOCS="authors.txt README TODO"
	mycmakeargs=( $(cmake-utils_use_enable lapack LAPACK) )
}

src_install() {
	cmake-utils_src_install

	for lang in ${LANGS} ; do
		case ${lang} in
			ca) dir=ca_ES;;
			cs) dir=cs_CZ;;
			*) dir=${lang};;
		esac
		use linguas_${lang} || rm -r "${D}"/usr/share/locale/${dir}
	done
}
