# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.0.6.ebuild,v 1.19 2003/09/06 22:25:50 msterret Exp $

inherit gnuconfig

DESCRIPTION="ODBC Interface for Linux"
HOMEPAGE="http://www.unixodbc.org/"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc hppa sparc alpha ~amd64"
IUSE="qt"

DEPEND="virtual/glibc
        >=sys-libs/readline-4.1
        >=sys-libs/ncurses-5.2
        qt? ( =x11-libs/qt-2.3* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.in Makefile.orig
	sed -e "s:touch :touch \${DESTDIR}/:" Makefile.orig > Makefile.in
	cp configure.in configure.orig
	sed -e "s:AC_CHECK_LIB *( *c *,:AC_CHECK_FUNC(:" configure.orig >configure.in
	cd gODBCConfig
	libtoolize
	aclocal
	cd ..
	libtoolize
	aclocal
	autoreconf-2.13

	use amd64 && gnuconfig_update
}

src_compile() {
	local myconf

	if [ "`use qt`" ]
	then
		myconf="--enable-gui=yes"
	else
		myconf="--enable-gui=no"
	fi

	export QTDIR=/usr/qt/2
	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc/unixODBC \
		    ${myconf} || die

	make || die
}

src_install() {
	dodir /etc/unixODBC
	make DESTDIR=${D} sysconfdir=${D}/etc/unixODBC install || die
	rm -r ${D}/var

	dodoc AUTHORS COPYING ChangeLog NEWS README*
	find doc/ -name "Makefile*" -exec rm '{}' \;
	dohtml doc/*
	prepalldocs
}
