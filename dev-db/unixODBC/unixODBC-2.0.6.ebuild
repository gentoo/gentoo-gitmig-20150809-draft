# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/unixODBC/unixODBC-2.0.6.ebuild,v 1.15 2003/05/22 02:07:25 weeve Exp $

IUSE="qt"

S=${WORKDIR}/${P}
DESCRIPTION="ODBC Interface for Linux"
SRC_URI="http://www.unixodbc.org/${P}.tar.gz"
HOMEPAGE="http://www.unixodbc.org"
LICENSE="GPL-2"
KEYWORDS="x86 ppc hppa sparc"
SLOT="0"
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
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc/unixODBC				\
		    ${myconf} || die

	make || die
}

src_install () {
	mkdir -p ${D}/etc/unixODBC
	make DESTDIR=${D} sysconfdir=${D}/etc/unixODBC install || die
	rm -r ${D}/var

	dodoc AUTHORS COPYING ChangeLog NEWS README*
	cp -a doc ${D}/usr/share/doc/${PF}/html
	find ${D}/usr/share/doc/${PF}/html -name "Makefile*" -exec rm {} \;
	prepalldocs
}
