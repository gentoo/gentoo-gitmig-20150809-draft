# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gda lib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-db/${A}
	 ftp://ftp.gnome-db.org/pub/gnome-db/sources/${PV}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-db"

RDEPEND="virtual/glibc
        >=gnome-base/gconf-1.0.4-r2
	>=gnome-base/oaf-0.6.6-r1
	>=gnome-base/bonobo-1.0.9-r1
        >=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
	>=dev-perl/CORBA-ORBit-0.4.3
	>=dev-db/sqlite-2.0.1
	mysql? ( >=dev-db/mysql-3.23.26 )
        postgres? ( >=dev-db/postgresql-7.1 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )"

DEPEND="${RDEPEND}
	sys-apps/which"

src_compile() {                           
	local myconf 

	if [ "`use mysql`" ]
	then
		myconf="--with-mysql=/usr"
	fi

  	if [ "`use ldap`" ]
	then
    		myconf="$myconf --with-ldap=/usr"
  	fi

  	if [ "`use odbc`" ]
	then
    		myconf="$myconf --with-odbc"
  	fi

  	if [ "`use postgres`" ]
	then
    		myconf="$myconf --with-postgres=/usr"
  	fi
  
  	# Wierd one, it dont detect bonobo. If someone could have a look
	# and fix if i havent gotten to it yet.
	myconf="$myconf --disable-bonobotest"
  
	./configure --host=${CHOST} 					\
		    --prefix=/usr	 				\
		    --sysconfdir=/etc		 			\
		    $myconf || die

	# Wierd hack I had to do to get it to compile (seems the buildin sqlite
	# do not compile by default).
	mv ${S}/providers/gda-default-server/gda-default.h ${S}/gda-default.h.orig
	sed -e 's/\"build_sqlite\/sqlite\.h\"/<sqlite.h>/' ${S}/gda-default.h.orig >${S}/providers/gda-default-server/gda-default.h
	ln -s /usr/lib/libsqlite.a ${S}/providers/gda-default-server/libsqlite.a

	# Doesn't work with -j 4 (hallski)
	make LDFLAGS="-lncurses" LIBREADLINE="-lreadline -lncurses" || die
}

src_install() {
	make  DESTDIR=${D} PREFIX=${D}/usr 				\
	      INSTALLMAN3DIR=${D}/usr/share/man/man3 			\
	      GDA_oafinfodir=${D}/usr/share/oaf install || die

	into /usr
	dobin providers/gda-default-server/build_sqlite/{lemon,sqlite}
	dodoc AUTHORS COPYING.* ChangeLog NEWS README
}
