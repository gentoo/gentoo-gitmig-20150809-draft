# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlgui/sqlgui-0.3.3.ebuild,v 1.6 2002/07/27 10:44:30 seemant Exp $

inherit kde-base || die

need-kde 3

newdepend ">=dev-db/mysql-3.23.38 >=kde-base/kdebase-3"

DESCRIPTION="This KDE 3 program lets you administer a mysql db"
SRC_URI="http://www.sqlgui.de/download/${P}.tar.gz"
HOMEPAGE="http://www.sqlgui.de/"
LICENSE="GPL-2"
KEYWORDS="x86"


myconf="$myconf --with-extra-includes=/usr/include/mysql"

