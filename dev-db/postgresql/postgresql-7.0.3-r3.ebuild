# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.0.3-r3.ebuild,v 1.4 2002/07/23 02:57:16 rphillips Exp $

S=${WORKDIR}/${P}/src
DESCRIPTION="PostgreSQL is a sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.postgresql.org/pub/v7.0.3/${P}.tar.gz"
HOMEPAGE="http://postgresql.readysetnet.com/"
LICENSE="POSTGRESQL"
SLOT="0"
DEPEND=">=dev-lang/tk-8"
KEYWORDS="x86"

src_unpack() {
  unpack ${A}
  cd ${S}/backend/catalog
  cp genbki.sh.in genbki.sh.orig
  sed -e 's:\\name:name:' genbki.sh.orig > genbki.sh.in
}

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr --host=${CHOST} \
	--enable-locale --with-tcl --enable-syslog
    cp Makefile.global Makefile.orig
    sed -e "s:^TEMPLATEDIR=.*:TEMPLATEDIR=\$(POSTGRESDIR)/lib/pgsql:" \
	-e "s:^HEADERDIR=.*:HEADERDIR=\$(POSTGRESDIR)/include/pgsql:" \
	-e "s:-O2:${CFLAGS}:" \
	Makefile.orig > Makefile.global
    try make

}

src_install () {

    cd ${S}
    dodir /usr/include/pgsql
    try make POSTGRESDIR=${D}/usr install
    dosed "s:/usr/pgaccess:/usr/lib/pgaccess:" /usr/bin/pgaccess
    cd ${D}/usr
    mv pgaccess lib
    cd lib/postgres
    cd ${S}/../doc
    dodoc FAQ* KNOWN_BUGS MISSING_FEATURES README*
    dodoc TODO* internals.ps bug.template
    dodoc *.tar.gz
	 exeinto /usr/bin
    doexe ${FILESDIR}/postmaster-wrapper
    exeinto /etc/rc.d/init.d/
    doexe ${FILESDIR}/pgsql
}


pkg_config() {
   mkdir -p /var/db/pgsql/data
   chown -R postgres /var/db/pgsql/data
   su - postgres -c "/usr/bin/initdb -D /var/db/pgsql/data"
}
