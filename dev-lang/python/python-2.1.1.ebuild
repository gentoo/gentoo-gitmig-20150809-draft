# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-2.1.1.ebuild,v 1.1 2001/08/05 16:28:52 darks Exp $

S=${WORKDIR}/Python-${PV}
S2=${WORKDIR}/python-fchksum-1.3
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/2.1.1/Python-${PV}.tgz 
	 http://www.azstarnet.com/~donut/programs/fchksum/python-fchksum-1.3.tar.gz"

HOMEPAGE="http://www.python.org http://www.azstarnet.com/~donut/programs/fchksum/"
DEPEND="virtual/glibc >=sys-libs/zlib-1.1.3
	readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )
	berkdb? ( >=sys-libs/db-3 )"

RDEPEND="$DEPEND"
PROVIDE="virtual/python"

src_unpack() {
    unpack Python-${PV}.tgz
   # cp ${FILESDIR}/setup.py ${S}
    cd ${S}/Modules
    cp Setup.dist Setup.tmp
    sed -e 's:#zlib .*:zlib zlibmodule.c -lz:' \
	-e 's:#syslog:syslog:' \
	-e 's:#crypt.*:crypt cryptmodule.c -lcrypt:' \
    Setup.tmp > Setup.dist

    if [ "`use readline`" ]
    then
        cp Setup.dist Setup.tmp
        sed -e 's/#readline/readline/' -e 's/-lreadline -ltermcap/-lreadline -lncurses/' \
        Setup.tmp > Setup.dist
    fi
    if [ "`use berkdb`" ]
    then
        cp Setup.dist Setup.tmp
        sed -e 's:#dbm.*:dbm dbmmodule.c -I/usr/include/db3 -ldb-3.2:' \
        Setup.tmp > Setup.dist
        cp dbmmodule.c dbmmodule.c.orig
        sed -e '10,25d' -e '26i\' -e '#define DB_DBM_HSEARCH 1\' -e 'static char *which_dbm = "BSD db";\' -e '#include <db3/db.h>' dbmmodule.c.orig > dbmmodule.c

    fi
    #cp Setup.dist Setup

    #sed -e
	#-e 's/#_locale/_locale/' -e 's/#crypt/crypt/' -e 's/# -lcrypt/-lcrypt/' \
	#-e 's/#syslog/syslog/' -e 's/#_curses _cursesmodule.c -lcurses -ltermcap/_curses _cursesmodule.c -lncurses/' \
	#-e 's:#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz:zlib zlibmodule.c -lz:' \
	#-e 's:#dbm.*:dbm dbmmodule.c -I/usr/include/db3 -ldb-3.2:' \
	#-e 's:^TKPATH=\:lib-tk:#TKPATH:' \
	#Setup.dist > Setup
	#echo "fchksum fchksum.c md5_2.c" >> Setup

	cd ${S}/Modules

	#patch the dbmmodule to use db3's dbm compatibility code.  That way, we're depending on db3 rather than
	#old db1.  We'll link with db3, of course.

   cp ${FILESDIR}/pfconfig.h .
   unpack python-fchksum-1.1.tar.gz

   cd python-fchksum-1.1
   mv md5.h ../md5_2.h
   sed -e 's:"md5.h":"md5_2.h":' md5.c > ../md5_2.c
   sed -e 's:"md5.h":"md5_2.h":' fchksum.c > ../fchksum.c

}


src_compile() {   
    cd ${S}
    try ./configure --prefix=/usr --without-libdb
	#libdb3 support is available from http://pybsddb.sourceforge.net/; the one
	#included with python is for db 1.85 only.
    cp Makefile Makefile.orig
    sed -e "s/-g -O2/${CFLAGS}/" Makefile.orig > Makefile
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
	dosym python2.1 /usr/bin/python
#    mv ${D}/bin/python1.5 ${D}/bin/spython1.5
   # for i in lib-dynload lib-stdwin lib-tk test
   # do
   #     rm -r ${D}/lib/python1.5/${i}
   # done
   # rm -r ${D}/include 
    dodoc README
}
