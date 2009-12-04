# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-4.0.2.ebuild,v 1.1 2009/12/04 13:12:55 ssuominen Exp $

EAPI=2
KDE_LINGUAS="bs cs de es fr hu it ja nl pl pt_BR ru sl sv tr uk zh_CN"
inherit kde4-base

DESCRIPTION="KRename - a very powerful batch file renamer."
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug exif taglib"

DEPEND="exif? ( >=media-gfx/exiv2-0.13 )
	taglib? ( >=media-libs/taglib-1.5 )"

DOCS="AUTHORS README TODO"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with exif EXIV2)
		$(cmake-utils_use_with taglib)"

	kde4-base_src_configure
}
