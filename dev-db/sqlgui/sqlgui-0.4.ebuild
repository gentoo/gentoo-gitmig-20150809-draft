# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlgui/sqlgui-0.4.ebuild,v 1.9 2004/04/16 02:19:11 vapier Exp $

inherit kde eutils
need-kde 3

MY_P="${PN}-${PV}.0"
DESCRIPTION="GUI for the dev-db/sqlguipart, administration tool for a mysql db"
HOMEPAGE="http://www.sqlgui.de/"
SRC_URI="http://www.sqlgui.de/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-db/mysql-3.23.38
	>=dev-db/sqlguipart-${PV}"

S=${WORKDIR}/${MY_P}/${P}

myconf="$myconf --with-extra-includes=/usr/include/mysql"


src_unpack() {
	cd ${WORKDIR}
	unpack ${A}
	cd ${MY_P}
	tar -xzpf ${P}.tar.gz || die
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.diff
}
