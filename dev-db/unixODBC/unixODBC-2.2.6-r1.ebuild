# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.2.6-r1.ebuild,v 1.4 2004/03/23 09:15:10 kumba Exp $

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~hppa ~alpha ~amd64 ~sparc"
IUSE="qt gnome"

DEPEND="virtual/glibc
	>=sys-libs/readline-4.1
	>=sys-libs/ncurses-5.2
	gnome? ( gnome-base/gnome-libs )
	qt? ( >=x11-libs/qt-3.0* )"

# the configure.in patch is required for 'use qt'
src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

# braindead check in configure fails - hack approach
	epatch ${FILESDIR}/${P}-configure.in.patch

	autoconf || die "autoconf failed"
}

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

	if [ "`use gnome`" ]
	then
		cd gODBCConfig
		./configure --host=${CHOST} \
				--prefix=/usr \
				--sysconfdir=/etc/unixODBC \
				${myconf} || die

		# not sure why these symlinks are needed. busted configure, i guess...
		ln -s ../depcomp .
		ln -s ../libtool .
		make || die
		cd ..
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	if [ "`use gnome`" ]
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
