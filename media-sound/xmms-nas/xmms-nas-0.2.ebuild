# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-nas/xmms-nas-0.2.ebuild,v 1.2 2001/05/09 10:21:22 achim Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A xmms plugin for NAS"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/xmms-nas-${PV}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

DEPEND="media-sound/xmms media-sound/nas"

src_compile() {

    local myprefix
    if [ "`use gnome`" ]
    then
      myprefix="/opt/gnome"
    else
      myprefix="/usr/X11R6"
    fi
    try ./configure --prefix=${myprefix} --host=${CHOST}
    if [ "`use gnome`" ]
    then
      cp Makefile Makefile.orig
      sed -e "s:^CFLAGS = :CFLAGS = -I/opt/gnome/include :" \
	Makefile.orig > Makefile
    fi
    touch config.h
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

