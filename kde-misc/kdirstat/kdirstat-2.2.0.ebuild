# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdirstat/kdirstat-2.2.0.ebuild,v 1.2 2004/11/24 23:37:06 swegener Exp $

inherit kde

DESCRIPTION="KDirStat - nice KDE replacement to du command"
HOMEPAGE="http://kdirstat.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdirstat/${P}.tgz"

LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86"

IUSE=""
SLOT="0"

need-kde 3
