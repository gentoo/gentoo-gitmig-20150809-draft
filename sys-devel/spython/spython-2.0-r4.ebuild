# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/spython/spython-2.0-r4.ebuild,v 1.5 2001/04/28 08:24:12 achim Exp $

S=${WORKDIR}/Python-2.0
S2=${WORKDIR}/python-fchksum-1.1
DESCRIPTION="A really great language -- minimalist python environment"
SRC_URI="http://www.python.org/ftp/python/src/BeOpen-Python-2.0.tar.bz2 
	 http://www.azstarnet.com/~donut/programs/fchksum/python-fchksum-1.1.tar.gz"

HOMEPAGE="http://www.python.org http://www.azstarnet.com/~donut/programs/fchksum/"

DEPEND=">=sys-libs/zlib-1.1.3 readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.2 )"

RDEPEND="virtual/glibc"
PROVIDE="virtual/python"

src_unpack() {

   unpack BeOpen-Python-2.0.tar.bz2

   cd ${S}/Modules

   cp ${FILESDIR}/pfconfig.h .
   unpack python-fchksum-1.1.tar.gz 

   echo '*static*' >> Setup.local

   echo "zlib zlibmodule.c -lz" >> Setup.local
   if [ "`use readline`" ]
   then
       echo "readline readline.c -lreadline -lncurses" >> Setup.local
   fi

   echo "fchksum fchksum.c md5_2.c" >> Setup.local

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

    export LDFLAGS=-static

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

    dodir /usr/share/man
    try make install prefix=${D}/usr MANDIR=${D}/usr/share/man
    rm ${D}/usr/bin/python
    mv ${D}/usr/bin/python2.0 ${D}/usr/bin/spython

    if [ "`use build`" ]
    then
        rm -rf ${D}/usr/share/man
    fi
}

pkg_postinst() {

  if [ ! -e "${ROOT}/usr/bin/python" ]
  then
    ln -s spython ${ROOT}/usr/bin/python
  fi
}
