# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimdaba/kimdaba-2.0.ebuild,v 1.7 2006/04/18 20:44:17 deathwing00 Exp $

inherit kde

DESCRIPTION="KDE Image Database (KimDaBa) is a tool for indexing, searching, and viewing images."
HOMEPAGE="http://ktown.kde.org/kimdaba/"
SRC_URI="http://ktown.kde.org/kimdaba/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

DEPEND="!media-gfx/kphotoalbum
	media-libs/libkipi
	|| ( kde-base/kdegraphics-kfile-plugins kde-base/kdegraphics )"
need-kde 3.2

pkg_postinst()
{
	einfo "Version 2.1 of media-gfx/kimdaba is the last one released"
	einfo "under that name. From version 2.2 and on, please use"
	einfo "media-gfx/kphotoalbum, after removing your current"
	einfo "media-gfx/kimdaba."
}

