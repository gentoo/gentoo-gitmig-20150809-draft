# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql/postgresql-7.1.ebuild,v 1.4 2001/04/22 18:38:00 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PostgreSQL is a sophisticated Object-Relational DBMS"
SRC_URI="ftp://ftp.postgresql.org/pub/v7.1/${P}.tar.gz
	 http://www.postgresql.org/~petere/rl42-pg.patch"
HOMEPAGE="http://postgresql.readysetnet.com/"

DEPEND="virtual/glibc
        >=sys-libs/readline-4.1
        >=sys-libs/ncurses-5.2
        tcltk? ( >=dev-lang/tcl-tk-8 )
        perl? ( sys-devel/perl )
        python? ( dev-lang/python )
        java? ( dev-lang/jdk >=dev-java/jaxp-1.0.1 >=dev-java/ant-1.3 )
        ssl? ( >=dev-libs/openssl-0.9.6-r1 )
        nls? ( sys-devel/gettext )"

src_unpack() {

  unpack ${P}.tar.gz

  cd ${S}

  # This is a patch from Peter Eisentraut
  patch -p0 < ${DISTDIR}/rl42-pg.patch
  # This patch is based on Lamar Owens, Thomas Lockhards and 
  # Thron Eivind Glomsrod work. Thanks you all.
  patch -p1 < ${FILESDIR}/${P}-perl5-GNUmakefile-gentoo.diff
  

}
if [ "`use java`" ]
then
        export JAVA_HOME="/opt/java"
        CLASSPATH=/opt/java/src.jar:/opt/java/lib/tools.jar
        CLASSPATH=$CLASSPATH:/usr/lib/java/jaxp.jar:/usr/lib/java/parser.jar
        CLASSPATH=$CLASSPATH:/usr/lib/java/ant.jar:/usr/lib/java/poptional.jar
        export CLASSPATH
fi

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
    fi
    if [ "`use nls`" ]
    then
        myconf="$myconf --enable-locale"
    fi
    try autoconf
    unset ROOT
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
    rm -rf ${D}/usr/doc ${D}/mnt
}

