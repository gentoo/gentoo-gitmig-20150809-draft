# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/lopster/lopster-0.9.9.ebuild,v 1.2 2001/06/24 20:12:40 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Napster Client using GTK"
SRC_URI="http://download.sourceforge.net/lopster/${A}"
HOMEPAGE="http://lopster.sourceforge.net"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )
	>=x11-libs/gtk+-1.2.8
        virtual/x11"

RDEPEND="virtual/glibc
	>=x11-libs/gtk+-1.2.8
        virtual/x11"

src_compile() {
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} gnulocaledir=${D}/usr/X11R6/locale install
    dodoc AUTHORS BUGS COPYING README ChangeLog NEWS
}

