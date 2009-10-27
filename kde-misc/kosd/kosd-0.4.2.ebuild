# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kosd/kosd-0.4.2.ebuild,v 1.1 2009/10/27 23:40:39 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="a simple KDE application that runs in the background and responds to button presses by showing a little OSD"
HOMEPAGE="http://www.kde-apps.org/content/show.php/KOSD?content=81457"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/81457-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/solid-${KDE_MINIMAL}
	>=kde-base/kmix-${KDE_MINIMAL}"
