# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.0-r2.ebuild,v 1.1 2001/04/28 09:51:03 achim Exp $

S=${WORKDIR}/Python-2.0
S2=${WORKDIR}/python-fchksum-1.1
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/src/BeOpen-Python-2.0.tar.bz2 
	 http://www.azstarnet.com/~donut/programs/fchksum/python-fchksum-1.1.tar.gz"

HOMEPAGE="http://www.python.org http://www.azstarnet.com/~donut/programs/fchksum/"
DEPEND="virtual/glibc
	>=dev-lang/tcl-tk-8.0.5
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )"

RDEPEND="$DEPEND >=sys-apps/bash-2.04"
PROVIDE="virtual/python-2.0"

src_unpack() {
    unpack BeOpen-Python-2.0.tar.bz2
    cd ${S}/Modules
    if [ "`use readline`" ]
    then
      sed -e 's/#readline/readline/' -e 's/-lreadline -ltermcap/-lreadline/' \
	  -e 's/#_curses _cursesmodule.c -lcurses -ltermcap/_curses _cursesmodule.c -lncurses/' \
	Setup.in > Setup.new
        mv Setup.new Setup.in
    fi

    if [ "`use berkdb`" ]
    then
      sed -e 's:#dbm.*:dbm dbmmodule.c -I/usr/include/db3 -ldb-3.2:' \
	Setup.in > Setup.new
        mv Setup.new Setup.in
    fi
   
    sed	-e 's/#_locale/_locale/' -e 's/#crypt/crypt/' -e 's/# -lcrypt/-lcrypt/' \
	-e 's/#syslog/syslog/'  \
	-e 's:#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz:zlib zlibmodule.c -lz:' \
	-e 's:^TKPATH=\:lib-tk:#TKPATH:' \
	Setup.in > Setup
	echo "fchksum fchksum.c md5_2.c" >> Setup

	cd ${S}/Modules

	if [ "`use berkdb`" ]
	then
  	  #patch the dbmmodule to use db3's dbm compatibility code.  That way, we're depending on db3 rather than
	  #old db1.  We'll link with db3, of course.
	  cp dbmmodule.c dbmmodule.c.orig
	  sed -e '10,25d' -e '26i\' -e '#define DB_DBM_HSEARCH 1\' -e 'static char *which_dbm = "BSD db";\' -e '#include <db3/db.h>' dbmmodule.c.orig > dbmmodule.c
	fi

   cp ${FILESDIR}/pfconfig.h .
   unpack python-fchksum-1.1.tar.gz 

   cd python-fchksum-1.1
   mv md5.h ../md5_2.h
   sed -e 's:"md5.h":"md5_2.h":' md5.c > ../md5_2.c
   sed -e 's:"md5.h":"md5_2.h":' fchksum.c > ../fchksum.c

	#for some reason, python 2.0 can't find /usr/lib/python2.0 without this fix to the source code.
	cd ${S}/Python
	cp pythonrun.c pythonrun.c.orig
	sed -e 's:static char \*default_home = NULL:static char \*default_home = "/usr":' pythonrun.c.orig > pythonrun.c
}


src_compile() {   
    cd ${S}
    try ./configure --prefix=/usr --without-libdb
	#libdb3 support is available from http://pybsddb.sourceforge.net/; the one
	#included with python is for db 1.85 only.
    cp Makefile Makefile.orig
    sed -e "s/-g -O2/${CFLAGS}/" Makefile.orig > Makefile
    cd ${S}/Modules
    cp Makefile.pre Makefile.orig
    sed -e "s:MODOBJS=:MODOBJS=fchksum.o md5_2.o:" \
    Makefile.orig > Makefile.pre

    # Parallel make does not work
    cd ${S}
    try make 
}

src_install() {                 
    dodir /usr            
    try make install prefix=${D}/usr
	rm ${D}/usr/bin/python
	dosym python2.0 /usr/bin/python

    dodoc README
}

