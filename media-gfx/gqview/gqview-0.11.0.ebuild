# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gqview/gqview-0.11.0.ebuild,v 1.4 2001/09/27 11:48:14 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME image browser"
SRC_URI="http://download.sourceforge.net/gqview/${A}"
HOMEPAGE="http://gqview.sourceforge.net"

DEPEND="virtual/glibc
	>=media-libs/gdk-pixbuf-0.10.0
	>=x11-libs/gtk+-1.2.0
	nls? ( sys-devel/gettext )"

myprefix=

src_compile() {
    local myconf
  
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} ${myconf}

    try pmake
}

src_install () {

   try make prefix=${D}/usr/X11R6 GNOME_DATADIR=${D}/opt/gnome/share install
   dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

