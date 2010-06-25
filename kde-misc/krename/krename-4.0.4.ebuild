# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/krename/krename-4.0.4.ebuild,v 1.1 2010/06/25 10:12:30 scarabeus Exp $

EAPI=2
KDE_LINGUAS="bs cs de es fr hu it ja nl pl pt_BR ru sl sv tr uk zh_CN"
inherit kde4-base

DESCRIPTION="KRename - a very powerful batch file renamer."
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug exif pdf taglib"

DEPEND="
	exif? ( >=media-gfx/exiv2-0.13 )
	pdf? ( >=app-text/podofo-0.8 )
	taglib? ( >=media-libs/taglib-1.5 )
"

DOCS="AUTHORS README TODO"

PATCHES=(
	"${FILESDIR}/4.0.4-podofo_automagic.patch"
)

src_configure() {
	mycmakeargs+=(
		$(cmake-utils_use_with exif EXIV2)
		$(cmake-utils_use_with taglib)
		$(cmake-utils_use_with pdf LIBPODOFO)
	)

	kde4-base_src_configure
}
