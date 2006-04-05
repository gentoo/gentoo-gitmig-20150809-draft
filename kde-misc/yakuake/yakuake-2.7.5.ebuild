# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/yakuake/yakuake-2.7.5.ebuild,v 1.2 2006/04/05 19:30:28 corsair Exp $

inherit kde

DESCRIPTION="A quake-style terminal emulator based on KDE konsole technology"
HOMEPAGE="http://extragear.kde.org/apps/yakuake/"
SRC_URI="http://www.kde-apps.org/content/files/29153-${P}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/konsole
	kde-base/kdebase )"

need-kde 3.3
