# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-0.2.9.ebuild,v 1.4 2001/08/31 23:32:48 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gda lib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-db/${A}"
HOMEPAGE="http://www.gnome.org/gnome-db"

RDEPEND="virtual/glibc
        >=gnome-base/gconf-0.11
        >=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
	mysql? ( >=dev-db/mysql-3.23.26 )
        postgres? ( >=dev-db/postgresql-7.1 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )"

DEPEND="${RDEPEND}
	sys-apps/which
	>=dev-perl/CORBA-ORBit-0.4.3"

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
  
	./configure --host=${CHOST} 					\
		    --prefix=/opt/gnome					\
		    --sysconfdir=/etc/opt/gnome				\
		    --mandir=/opt/gnome/man				\
		    $myconf || die

	# Doesn't work with -j 4 (hallski)
	make LDFLAGS="-lncurses" LIBREADLINE="-lreadline -lncurses" || die
}

src_install() {
	make DESTDIR=${D} PREFIX=${D}/usr 				\
	     INSTALLMAN3DIR=${D}/usr/share/man/man3			\
	     GDA_oafinfodir=${D}/opt/gnome/share/oaf install || die

	into /usr
	dobin providers/gda-default-server/build_sqlite/{lemon,sqlite}
	dodoc AUTHORS COPYING.* ChangeLog NEWS README
}
