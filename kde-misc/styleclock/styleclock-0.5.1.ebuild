# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/styleclock/styleclock-0.5.1.ebuild,v 1.9 2009/10/13 22:00:06 ssuominen Exp $

EAPI=2
inherit kde

DESCRIPTION="StyleClock is a better-looking themable replacement for the regular KDE clock with alarm and timer"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=14423"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

DEPEND="virtual/opengl
	x11-libs/qt:3[opengl]"

need-kde 3.5
