# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gqview/gqview-0.11.0.ebuild,v 1.3 2001/07/29 10:39:39 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME image browser"
SRC_URI="http://download.sourceforge.net/gqview/${A}"
HOMEPAGE="http://gqview.sourceforge.net"

DEPEND="virtual/glibc
	media-libs/gdk-pixbuf
	nls? ( sys-devel/gettext )"

src_compile() {
    local myconf
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi

    try ./configure --prefix=/opt/gnome --mandir=/opt/gnome/share/man \
	--host=${CHOST} ${myconf}
    try pmake

}

src_install () {

    try make prefix=${D}/opt/gnome mandir=${D}/opt/gnome/share/man \
	GNOME_DATADIR=${D}/opt/gnome/share install

}

