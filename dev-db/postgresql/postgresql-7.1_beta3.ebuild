# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.0.3-r1.ebuild,v 1.4 2001/01/23 19:54:43 achim Exp

P=postgresql-7.1beta3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="PostgreSQL is a sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.postgresql.org/pub/dev/${A}"
HOMEPAGE="http://postgresql.readysetnet.com/"

src_unpack() {
  unpack ${A}
  cd ${S}/src/backend/catalog
  cp genbki.sh genbki.sh.orig
#  sed -e 's:\\name:\\ name:' genbki.sh.orig > genbki.sh
}

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST} \
	--datadir=/usr/share/postgres --includedir=/usr/include/postgres \
	--enable-locale --with-tcl --enable-syslog
    try make

}

src_install () {

    try make prefix=${D}/usr includedir=${D}/usr/include/postgres \
		datadir=${D}/usr/share/postgres install
}

