# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqlguipart/sqlguipart-0.4.ebuild,v 1.4 2003/03/01 04:50:37 vapier Exp $

inherit kde-base

need-kde 3

newdepend ">=dev-db/mysql-3.23.38
	>=kde-base/kdebase-3"

DESCRIPTION="kpart for administering a mysql db. dev-db/sqlgui is a gui for it."
SRC_URI="http://www.sqlgui.de/download/sqlgui-0.4.0.tar.gz"
HOMEPAGE="http://www.sqlgui.de/"

LICENSE="GPL-2"
KEYWORDS="x86"

myconf="${myconf} --with-extra-includes=/usr/include/mysql"

S=${WORKDIR}/sqlgui-0.4.0/${P}

src_unpack() {
	cd $WORKDIR
	unpack sqlgui-0.4.0.tar.gz
	cd sqlgui-0.4.0
	tar -xvzpf $P.tar.gz
	cd $S
	patch -p0 < $FILESDIR/$P-gcc3.diff
	patch -p0 < $FILESDIR/$P-gentoo.diff
	need-autoconf 2.1
	make -f Makefile.dist
	need-autoconf 2.5
}
