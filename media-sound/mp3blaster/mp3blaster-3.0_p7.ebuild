# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org> 

A=${PN}-3.0p7.tar.gz
S=${WORKDIR}/mp3blaster-3.0p7/
DESCRIPTION="MP3 command line player"
SRC_URI="ftp://mud.stack.nl/pub/mp3blaster/${A}"
HOMEPAGE="http://www.stack.nl/~brama/mp3blaster"

DEPEND=">=sys-libs/ncurses-5.2
	nas? ( >=media-sound/nas-1.4.1 )
	mysql? ( >=dev-db/mysql-3.23.36 )"


src_compile() {
    local myconf
    if [ "`use nas`" ] ; then
	myconf="--with-nas"
    fi
    if [ "`use mysql`" ] ; then
	myconf="$myconf --with-mysql"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} ${myconf}
    if [ "`use nas`" ] ; then
	cd src
	cp Makefile Makefile.orig
	sed -e "s:^INCLUDES =:INCLUDES = -I/usr/X11R6/include:" \
	    -e "s:^splay_LDADD =:splay_LDADD = \$(NAS_LIBS):" Makefile.orig > Makefile
	cd ..
    fi
    try make 

}

src_install () {
    try make DESTDIR=${D} install

    dodoc ANNOUNCE AUTHORS COPYING CREDITS ChangeLog FAQ NEWS README TODO

}

