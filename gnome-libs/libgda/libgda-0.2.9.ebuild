# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gda lib"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/gnome-db/${A}"
HOMEPAGE="http://www.gnome.org/gnome-db"

DEPEND="virtual/glibc sys-apps/which
        >=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
        >=gnome-base/gconf-0.11
	>=dev-perl/CORBA-ORBit-0.4.3
	mysql? ( >=dev-db/mysql-3.23.26 )
        postgres? ( >=dev-db/postgresql-7.1 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )"

RDEPEND="virtual/glibc
        >=gnome-base/gconf-0.11
        >=sys-libs/gdbm-1.8.0
        >=sys-libs/readline-4.1
	mysql? ( >=dev-db/mysql-3.23.26 )
        postgres? ( >=dev-db/postgresql-7.1 )
	odbc? ( >=dev-db/unixODBC-1.8.13 )
	ldap? ( >=net-nds/openldap-1.2.11 )"

src_compile() {                           
  local myconf 
  if [ "`use mysql`" ] ; then
    myconf="--with-mysql=/usr"
  fi
  if [ "`use ldap`" ] ; then
    myconf="$myconf --with-ldap=/usr"
  fi
  if [ "`use odbc`" ]; then
    myconf="$myconf --with-odbc"
  fi
  if [ "`use postgres`" ]; then
    myconf="$myconf --with-postgres=/usr"
  fi
  
  try  ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome $myconf
  try make LDFLAGS=\"-lncurses\" LIBREADLINE=\"-lreadline -lncurses\"  # Doesn't work with -j 4 (hallski)
}

src_install() {
  try make prefix=${D}/opt/gnome sysconfdir=/etc/opt/gnome \
        PREFIX=${D}/usr INSTALLMAN3DIR=${D}/usr/share/man/man3 \
	GDA_oafinfodir=${D}/opt/gnome/share/oaf install
  into /usr
  dobin providers/gda-default-server/build_sqlite/{lemon,sqlite}
  dodoc AUTHORS COPYING.* ChangeLog NEWS README
}




