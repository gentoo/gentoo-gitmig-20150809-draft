# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.1.ebuild,v 1.2 2001/04/17 19:40:09 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PostgreSQL is a sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.postgresql.org/pub/v7.1/${P}.tar.gz
	 http://www.postgresql.org/~petere/rl42-pg.patch"
HOMEPAGE="http://postgresql.readysetnet.com/"

DEPEND="virtual/glibc
        >=sys-libs/readline-4.2
        >=sys-libs/ncurses-5.2
        tcltk? ( >=dev-lang/tcl-tk-8 )
        perl? ( sys-devel/perl )
	python? ( dev-lang/python )
        java? ( dev-lang/jdk )
	ssl? ( >=dev-libs/openssl-0.9.6-r1 )
        nls? ( sys-devel/gettext )"

src_unpack() {
  unpack ${P}.tar.gz
  cd ${S}
  patch -p0 < ${DISTDIR}/rl42-pg.patch
  patch -p1 < ${FILESDIR}/${P}-perl5-GNUmakefile-gentoo.diff
}

src_compile() {

    local myconf
    if [ "`use tcltk`" ]
    then
        myconf="--with-tcl"
    fi
    if [ "`use perl`" ]
    then
        myconf="$myconf --with-perl"
    fi
    if [ "`use python`" ]
    then
        myconf="$myconf --with-python"
    fi
    if [ "`use java`" ]
    then
        myconf="$myconf --with-java"
        export JAVA_HOME="/opt/java"
    fi
    if [ "`use nls`" ]
    then
        myconf="$myconf --enable-locale"
    fi
    try autoconf
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} \
	--enable-syslog $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc COPYRIGHT HISTORY README register.txt
    cd ${S}/doc
    dodoc FAQ* KNOWN_BUGS MISSING_FEATURES README*
    dodoc TODO internals.ps bug.template
    dodoc *.tar.gz
    docinto sgml
    dodoc src/sgml/*.{sgml,dsl}
    docinto sgml/ref
    dodoc src/sgml/ref/*.sgml
    docinto sgml/graphics
    dodoc src/graphics/*
    mv ${D}/usr/doc/postgresql/html ${D}/usr/share/doc/${PF}
    rm -rf ${D}/usr/doc
}

