# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-nas/xmms-nas-0.2-r1.ebuild,v 1.1 2001/10/06 17:22:51 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A xmms plugin for NAS"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/xmms-nas-${PV}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

DEPEND="media-sound/xmms media-sound/nas"

src_compile() {

    try ./configure --prefix=/usr --host=${CHOST}
#    if [ "`use gnome`" ]
#    then
#      cp Makefile Makefile.orig
#      sed -e "s:^CFLAGS = :CFLAGS = -I/opt/gnome/include :" \
#	Makefile.orig > Makefile
#    fi
    touch config.h
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}

