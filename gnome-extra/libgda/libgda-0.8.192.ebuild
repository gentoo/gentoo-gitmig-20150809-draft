# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-0.8.192.ebuild,v 1.3 2002/08/16 04:13:58 murphy Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="gda library"
SRC_URI="ftp://ftp.gnome-db.org/pub/gnome-db/sources/v0.8.192/${P}.tar.gz
	 ftp://ftp.gnome.org/pub/gnome/2.0.0/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/gnome-db"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/oaf-0.6.8
	>=gnome-base/gconf-1.2.0
	>=dev-libs/libxslt-1.0.19
	>=dev-libs/popt-1.6.3
	>=sys-libs/zlib-1.1.4
	mysql? ( >=dev-db/mysql-3.23.51 )
	postgres? ( >=dev-db/postgresql-7.2.1 )
	odbc? ( >=dev-db/unixODBC-2.0.6 )
	sqlite? ( >=dev-db/sqlite-2.4.2 )"

src_compile() {

	local myconf 

	if [ "`use mysql`" ]
	then
		myconf="--with-mysql=/usr"
	else
		myconf="--without-mysql"
	fi

  	if [ "`use postgres`" ]
	then
    		myconf="$myconf --with-postgres=/usr"
	else
		myconf="$myconf --without-postgres"
  	fi

  	if [ "`use odbc`" ]
	then
    		myconf="$myconf --with-odbc"
	else
		myconf="$myconf --without-odbc"
  	fi

	if [ "`use sqlite`" ]
	then
		myconf="$myconf --with-sqlite=/usr"
	else
		myconf="$myconf --without-sqlite"
	fi

	econf $myconf || die "configure failed"

	# Doesn't work with -j 4 (hallski)
	make LDFLAGS="-lncurses" LIBREADLINE="-lreadline -lncurses" \
		|| die "make failed"
}

src_install() {

	cd ${S}/doc
	cp Makefile Makefile.old
	sed -e "s:scrollkeeper-update.*::g" Makefile.old > Makefile
	rm Makefile.old
	cd ${S}

	make  prefix=${D}/usr \
	      sysconfdir=${D}/etc \
	      localstatedir=${D}/var/lib \
	      INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	      GDA_oafinfodir=${D}/usr/share/oaf \
              idldir=${D}/usr/share/idl/libgda \
              dtddir=${D}/usr/share/libgda/dtd \
              datadir=${D}/usr/share \
	      install || die

	dodoc AUTHORS COPYING.* ChangeLog NEWS README
}
