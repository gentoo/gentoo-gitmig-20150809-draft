# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlguipart/sqlguipart-0.5.1.ebuild,v 1.1 2003/09/16 21:44:07 caleb Exp $

inherit kde eutils
need-kde 3.1
newdepend ">=dev-db/mysql-3.23.38
	>=kde-base/kdebase-3.1"

DESCRIPTION="kpart for administering a mysql db. dev-db/sqlgui is a gui for it."
SRC_URI="http://www.sqlgui.de/download/${P}.tar.gz"
HOMEPAGE="http://www.sqlgui.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

myconf="${myconf} --with-extra-includes=/usr/include/mysql"

src_unpack() {
	kde_src_unpack
}
