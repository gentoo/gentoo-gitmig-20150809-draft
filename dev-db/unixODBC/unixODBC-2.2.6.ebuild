# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.6.ebuild,v 1.20 2006/11/17 23:23:41 compnerd Exp $

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa alpha amd64 sparc ia64"
IUSE="qt3"

DEPEND="virtual/libc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	qt3? ( =x11-libs/qt-3* )"

src_compile() {
	local myconf

	if use qt3
	then
		myconf="--enable-gui=yes --x-libraries=/usr/lib --x-includes=/usr/include/X11"
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
