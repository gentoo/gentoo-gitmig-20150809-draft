# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.0.3.ebuild,v 1.1 2000/11/26 12:38:24 achim Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}/src
DESCRIPTION="PostgreSQL is a sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.postgresql.org/pub/v7.0.3/${A}"
HOMEPAGE="http://postgresql.readysetnet.com/"


src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	--enable-locale --with-tcl --enable-syslog
    cp Makefile.global Makefile.orig
    sed -e "s:^TEMPLATEDIR=.*:TEMPLATEDIR=\$(POSTGRESDIR)/lib/postgres:" \
	-e "s:^HEADERDIR=.*:HEADERDIR=\$(POSTGRESDIR)/include/postgres:" \
	-e "s:-O2:${CFLAGS}:" \
	Makefile.orig > Makefile.global
    try make

}

src_install () {

    cd ${S}
    try make POSTGRESDIR=${D}/usr install

}

