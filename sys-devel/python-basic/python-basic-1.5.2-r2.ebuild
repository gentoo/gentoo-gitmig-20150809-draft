# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/python-basic/python-basic-1.5.2-r2.ebuild,v 1.2 2000/10/20 09:19:45 achim Exp $

P=python-basic-1.5.2      
A="py152.tgz python-fchksum-1.1.tar.gz"
S=${WORKDIR}/Python-1.5.2
S2=${WORKDIR}/python-fchksum-1.1
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/src/py152.tgz 
	 http://www.azstarnet.com/~donut/programs/fchksum/python-fchksum-1.1.tar.gz"

HOMEPAGE="http://www.python.org
	  http://www.azstarnet.com/~donut/programs/fchksum/"


src_compile() {                           
    try ./configure --prefix=/usr --with-threads
    cp Makefile Makefile.orig
    sed -e "s/-g -O2/${CFLAGS}/" Makefile.orig > Makefile
    try make
	cd ${S2}
	./configure
	try make
}

src_unpack() {
    unpack ${A}
    cd ${S}/Modules
    sed -e 's/#readline/readline/' -e 's/-lreadline -ltermcap/-lreadline/' \
-e 's/#_locale/_locale/' -e 's/#crypt/crypt/' -e 's/# -lcrypt/-lcrypt/' \
-e 's/#audioop/audioop/' -e 's/#imageop/imageop/' -e 's/#rgbimg/rgbimg/' \
-e 's/#syslog/syslog/' -e 's/#curses cursesmodule.c -lcurses -ltermcap/curses cursesmodule.c -lncurses/' \
-e 's:#gdbm gdbmmodule.c -I/usr/local/include -L/usr/local/lib -lgdbm:gdbm gdbmmodule.c -lgdbm:' \
-e 's:#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz:zlib zlibmodule.c -lz:' \
Setup.in > Setup
}


src_install() {                 
    dodir /usr              
    try make install prefix=${D}/usr
	cd ${S2}
	try make prefix=${D}/usr install
	cd ${S}
    prepman
    strip ${D}/usr/bin/python

#DOC

    dodoc README

}

