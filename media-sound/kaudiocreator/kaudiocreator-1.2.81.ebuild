# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kaudiocreator/kaudiocreator-1.2.81.ebuild,v 1.1 2009/11/03 13:57:23 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="KDE CD ripper and audio encoder frontend"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=107645"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/107645-${P}.tar.bz2"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/libkcddb-${KDE_MINIMAL}
	>=kde-base/libkcompactdisc-${KDE_MINIMAL}
	>=media-libs/taglib-1.5"

DOCS="Changelog TODO"
