# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kimdaba/kimdaba-1.0.1.ebuild,v 1.4 2006/04/18 20:44:17 deathwing00 Exp $

inherit kde
need-kde 3

IUSE=""
SLOT="0"

DESCRIPTION="KDE Image Database"
SRC_URI="http://ktown.kde.org/kimdaba/download/${P}.tar.bz2"
HOMEPAGE="http://ktown.kde.org/kimdaba/"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="!media-gfx/kphotoalbum"

pkg_postinst()
{
	einfo "Version 2.1 of media-gfx/kimdaba is the last one released"
	einfo "under that name. From version 2.2 and on, please use"
	einfo "media-gfx/kphotoalbum, after removing your current"
	einfo "media-gfx/kimdaba."
}

