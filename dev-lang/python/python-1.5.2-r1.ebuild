# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/python/python-1.5.2-r1.ebuild,v 1.3 2000/09/15 20:08:47 drobbins Exp $

P=python-1.5.2      
A=py152.tgz
S=${WORKDIR}/Python-1.5.2
DESCRIPTION="A really great language"
SRC_URI="http://www.python.org/ftp/python/src/py152.tgz"
HOMEPAGE="http://www.python.org/"

src_compile() {                           
    try ./configure --prefix=/usr --with-threads
    cp Makefile Makefile.orig
    sed -e "s/-g -O2/${CFLAGS}/" Makefile.orig > Makefile
    try make
}

src_unpack() {
    unpack ${A}
    cd ${S}/Modules
    sed -e 's/#readline/readline/' -e 's/-lreadline -ltermcap/-lreadline/' \
-e 's/#_locale/_locale/' -e 's/#crypt/crypt/' -e 's/# -lcrypt/-lcrypt/' \
-e 's/#audioop/audioop/' -e 's/#imageop/imageop/' -e 's/#rgbimg/rgbimg/' \
-e 's/# _tkinter/_tkinter/' -e 's:-DWITH_APPINIT \\:-DWITH_APPINIT -I/usr/X11R6/include -ltk8.1 -ltcl8.1 -L/usr/X11R6/lib -lX11:' \
-e 's/#syslog/syslog/' -e 's/#curses cursesmodule.c -lcurses -ltermcap/curses cursesmodule.c -lncurses/' \
-e 's:#gdbm gdbmmodule.c -I/usr/local/include -L/usr/local/lib -lgdbm:gdbm gdbmmodule.c -lgdbm:' \
-e 's:#zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz:zlib zlibmodule.c -lz:' \
Setup.in > Setup
}


src_install() {                 
    dodir /usr              
    try make install prefix=${D}/usr
    prepman
    strip ${D}/usr/bin/python

#DOC

    dodoc README

}

