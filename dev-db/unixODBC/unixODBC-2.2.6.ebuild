# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.6.ebuild,v 1.1 2003/11/21 19:16:19 rphillips Exp $

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~hppa ~alpha amd64"
IUSE="qt"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	qt? ( >=x11-libs/qt-3.0* )"

src_compile() {
	local myconf

	if [ "`use qt`" ]
	then
		myconf="--enable-gui=yes"
	else
		myconf="--enable-gui=no"
	fi

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc/unixODBC \
		    ${myconf} || die

	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README*
	find doc/ -name "Makefile*" -exec rm '{}' \;
	dohtml doc/*
	prepalldocs
}
