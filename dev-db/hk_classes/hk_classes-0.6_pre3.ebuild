# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/hk_classes/hk_classes-0.6_pre3.ebuild,v 1.1 2003/04/24 12:29:21 pauldv Exp $

NEWP=${P/_pre3/-pre3a}
DESCRIPTION="GUI-independent C++ libraries for database applications"
HOMEPAGE="http://hk-classes.sourceforge.net/"
SRC_URI="http://hk-classes.sourceforge.net/${NEWP}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql postgres odbc"

# At least one of the following is required
DEPEND="|| ( mysql? ( >=dev-db/mysql-3.23.54a )
	     postgres? ( >=dev-db/postgresql-7.3 ) 
             odbc? ( >=dev-db/unixODBC-2.0.6 ) )"
	
S=${WORKDIR}/${NEWP}

src_compile() {
	local myconf
	myconf="--host=${CHOST} --prefix=/usr/lib/hk_classes \
  		--with-hk_classes-incdir=/usr/include/hk_classes \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man"

	use mysql && myconf="${myconf} --with-mysql-incdir=/usr/include/mysql \
  		--with-mysql-libdir=/usr/lib/mysql"
	use postgres && myconf="${myconf} --with-postgres-incdir=/usr/include/postgresql \
  		--with-postgres-libdir=/usr/lib/postgresql"
	use odbc && myconf="${myconf} --with-odbc-incdir=/usr/include \
  		--with-odbc-libdir=/usr/lib"
	
	./configure ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
