# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kphotoalbum/kphotoalbum-2.2.ebuild,v 1.13 2007/07/12 04:08:47 mr_bones_ Exp $

inherit kde

IUSE="exif"
DESCRIPTION="KDE Photo Album is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://www.kphotoalbum.org/"
SRC_URI="http://www.kphotoalbum.org/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc sparc x86"

DEPEND="!media-gfx/kimdaba
	exif? ( >=media-libs/libkexif-0.2.1
		>=media-gfx/exiv2-0.9.1 )
	>=media-libs/libkipi-0.1
	|| ( kde-base/kdegraphics-kfile-plugins kde-base/kdegraphics )"

need-kde 3.2

pkg_setup()
{
	setupok=1
	if use exif ; then
		if ! built_with_use =x11-libs/qt-3* sqlite ; then
			elog "To enable KPhotoAlbum to search your images"
			elog "using EXIF information you also need to have"
			elog "Qt installed with SQLite support."
			elog
			elog "Make sure your Qt is installed with the sqlite USE flag."
			setupok=0
		fi
		if [ $setupok != 0 ] ; then
			slot_rebuild "media-libs/libkipi media-libs/libkexif"
			setupok=$?
		fi
	else
		slot_rebuild "media-libs/libkipi"
		setupok=$?
	fi
	if [ $setupok == 0 ] ; then
		die
	fi
}
