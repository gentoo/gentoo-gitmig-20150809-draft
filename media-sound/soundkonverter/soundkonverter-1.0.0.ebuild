# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/soundkonverter/soundkonverter-1.0.0.ebuild,v 1.2 2011/08/11 19:46:09 dilfridge Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Frontend to various audio converters"
HOMEPAGE="http://www.kde-apps.org/content/show.php/soundKonverter?content=29024"
SRC_URI="http://kde-apps.org/CONTENT/content-files/29024-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/taglib
	media-sound/cdparanoia
"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-underlinking.patch" )
