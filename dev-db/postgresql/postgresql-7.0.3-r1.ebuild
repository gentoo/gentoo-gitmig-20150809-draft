# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.0.3-r1.ebuild,v 1.3 2001/01/23 16:23:37 achim Exp $

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
    dodir /usr/include/postgres
    try make POSTGRESDIR=${D}/usr install
    dosed "s:/usr/pgaccess:/usr/lib/pgaccess:" /usr/bin/pgaccess
    cd ${D}/usr
    mv pgaccess lib
    cd lib/postgres
    for i in global1 local1_template1
    do
      cp $i.bki.source $i.orig
      sed -e "s:= ame:= name:" $i.orig > $i.bki.source
      rm $i.orig
    done
    cd ${S}/../doc
    dodoc FAQ* KNOWN_BUGS MISSING_FEATURES README*
    dodoc TODO* internals.ps bug.template
    dodoc *.tar.gz
}

