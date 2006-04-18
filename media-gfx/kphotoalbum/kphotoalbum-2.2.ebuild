# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-2.2.ebuild,v 1.1 2006/04/18 19:36:30 deathwing00 Exp $

inherit kde
need-kde 3

IUSE="exif"
DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://www.kphotoalbum.org/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="!media-gfx/kimdaba
	exif? ( >=media-libs/libkexif-0.2.1
		>=media-gfx/exiv2-0.9.1 )
	>=media-libs/libkipi-0.1
	|| ( kde-base/kdegraphics-kfile-plugins kde-base/kdegraphics )"

pkg_postinst()
{
	if use exif; then
		einfo "To enable KPhotoAlbum to search your images"
		einfo "using EXIF information you also need to have"
		einfo "Qt installed with SQLite support."
		einfo
		einfo "Make sure your Qt is installed with the sqlite USE flag."
	fi
}
