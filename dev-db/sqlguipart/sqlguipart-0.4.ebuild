# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlguipart/sqlguipart-0.4.ebuild,v 1.5 2003/04/23 15:02:17 vapier Exp $

inherit kde-base eutils
need-kde 3
newdepend ">=dev-db/mysql-3.23.38
	>=kde-base/kdebase-3"

MY_P="sqlgui-${PV}.0"
DESCRIPTION="kpart for administering a mysql db. dev-db/sqlgui is a gui for it."
SRC_URI="http://www.sqlgui.de/download/${MY_P}.tar.gz"
HOMEPAGE="http://www.sqlgui.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

myconf="${myconf} --with-extra-includes=/usr/include/mysql"

S=${WORKDIR}/${MY_P}/${P}

src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${MY_P}
	tar -xzpf ${P}.tar.gz || die
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.diff
	epatch ${FILESDIR}/${P}-gentoo.diff
	need-autoconf 2.1
	make -f Makefile.dist
	need-autoconf 2.5
}
