# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.6.ebuild,v 1.19 2006/06/24 15:08:38 cardoe Exp $

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa alpha amd64 sparc ia64"
IUSE="qt3 gnome"

DEPEND="virtual/libc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	qt3? ( =x11-libs/qt-3* )
	gnome? ( gnome-base/gnome-libs )"

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

	if use gnome
	then
		# Symlink for configure
		ln -s ${S}/odbcinst/.libs ./lib
		# Symlink for libtool
		ln -s ${S}/odbcinst/.libs ./lib/.libs
		cd gODBCConfig
		./configure --host=${CHOST} \
				--with-odbc=${S} \
				--prefix=/usr \
				--x-libraries=/usr/lib \
				--sysconfdir=/etc/unixODBC \
				|| die

		# not sure why these symlinks are needed. busted configure, i guess...
		ln -s ../depcomp .
		ln -s ../libtool .
		make || die
		cd ..
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	if use gnome
	then
		cd gODBCConfig
		make DESTDIR=${D} install || die
		cd ..
	fi

	dodoc AUTHORS COPYING ChangeLog NEWS README*
	find doc/ -name "Makefile*" -exec rm '{}' \;
	dohtml doc/*
	prepalldocs
}
