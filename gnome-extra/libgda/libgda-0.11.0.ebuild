# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgda/libgda-0.11.0.ebuild,v 1.1 2003/03/15 22:52:17 liquidx Exp $

IUSE="odbc postgres mysql ldap"

inherit gnome2 gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Database Access Library"
HOMEPAGE="http://www.gnome-db.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="~x86"

RDEPEND=">=gnome-base/ORBit2-2.3.91
   >=dev-libs/glib-2.0.4
   >=gnome-base/bonobo-activation-0.7.0
   >=gnome-base/libbonobo-2.0.0
   >=dev-libs/libxml2-2.4.23
   >=gnome-base/gconf-1.2.0
   >=dev-libs/libxslt-1.0.9
   >=gnome-base/gnome-vfs-2.0.0
   dev-libs/popt
   sys-libs/readline
   sys-libs/ncurses
   mysql? ( >=dev-db/mysql-3.23.51 )
   postgres? ( >=dev-db/postgresql-7.2.1 )
   odbc? ( >=dev-db/unixODBC-2.0.6 )
   ldap? ( net-nds/openldap )"
   
# removing un-ratified use flags
# sqlite? ( >=dev-db/sqlite-2.4.2 )
# freetds? ( >=dev-db/freetds-0.53 )

DEPEND=">=dev-util/pkgconfig-0.8
   >=dev-util/intltool-0.22
   ${RDEPEND}"

src_compile() {

	local myconf 

	if [ -n "`use mysql`" ]; then
		myconf="--with-mysql=/usr"
	else
		myconf="--without-mysql"
	fi

  	if [ -n "`use postgres`" ]; then
        myconf="${myconf} --with-postgres=/usr"
	else
		myconf="${myconf} --without-postgres"
  	fi

  	if [ -n "`use odbc`" ]; then
        myconf="${myconf} --with-odbc=/usr"
	else
		myconf="${myconf} --without-odbc"
  	fi

    if [ -n "`use ldap`" ]; then
        myconf="${myconf} --with-ldap=/usr"
    else
        myconf="${myconf} --without-ldap"
    fi

    # disabling unratified USE flags
    
	#if [ -n "`use sqlite`" ]; then
	#	myconf="$myconf --with-sqlite=/usr"
	#else
	#	myconf="$myconf --without-sqlite"
	#fi

    #if [ -n "`use freetds`" ]; then
	#    myconf="$myconf --with-tds=/usr"
	#else
	#    myconf="$myconf --without-tds"
	#fi

    # not setting these, because we should allow
    # libgda to autodetect the environment if
    # there are no use flags for these backends.
    
    #myconf="${myconf} --without-sqlite"
    #myconf="${myconf} --without-tds"
    #myconf="${myconf} --without-ibmdb2"
    #myconf="${myconf} --without-sybase"
    #myconf="${myconf} --without-oracle"
    #myconf="${myconf} --without-firebird"
    #myconf="${myconf} --without-mdb"

	gnome2_src_compile ${myconf}

}
