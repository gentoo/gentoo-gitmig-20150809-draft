# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-3.1.1-r2.ebuild,v 1.1 2009/02/08 23:07:15 carlo Exp $

ARTS_REQUIRED="never"

USE_KEG_PACKAGING=1
LANGS="ar be br ca cs cy da de el en_GB es et fi fr ga gl hi is it ja ka lt ms
mt nb nds nl pa pl pt pt_BR ro ru rw sk sr sr@Latn sv ta tr uk vi zh_CN"
KEG_PO_DIR=translations
inherit kde

DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://www.kphotoalbum.org/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="exif raw"

DEPEND="exif? ( >=media-gfx/exiv2-0.15 )
	raw? ( >=media-libs/libkdcraw-0.1.1 )
	>=media-libs/jpeg-6b-r7
	>=media-libs/libkipi-0.1
	|| ( =kde-base/kdegraphics-kfile-plugins-3.5* =kde-base/kdegraphics-3.5* )"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-gcc-4.3.patch"
		"${FILESDIR}/kphotoalbum-3.1.1-desktop-files-fixes.diff" )

pkg_setup() {
	if use exif && ! built_with_use =x11-libs/qt-3* sqlite ; then
		eerror "To enable KPhotoAlbum to search your images"
		eerror "using EXIF information you also need to have"
		eerror "Qt installed with SQLite support."
		eerror
		eerror "Make sure your Qt is installed with the sqlite USE flag."
		die
	fi
	kde_pkg_setup
}

src_compile() {
	local myconf="$(use_enable raw kdcraw) $(use_enable exif exiv2)"
	kde_src_compile
}
