# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/gnapster/gnapster-1.5.0-r1.ebuild,v 1.1 2001/10/06 10:38:04 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A napster client for GTK/GNOME"
SRC_URI="http://jasta.gotlinux.org/files/${P}.tar.gz"
HOMEPAGE="http://jasta.gotlinux.org/gnapster.html"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1
                 >=media-libs/gdk-pixbuf-0.11.0-r1 )"

src_compile() {

    local myconf
    if [ -z "`use nls`" ] ; then
      myopts="--disable-nls"
    fi
    if [ "`use gnome`" ]
    then
      try ./configure --prefix=/usr --host=${CHOST} ${myopts}
    else
      try ./configure --disable-gnome --prefix=/usr --host=${CHOST} ${myopts}
      try pmake
    fi
}

src_install () {
    if [ "`use gnome`" ]
    then
      try make prefix=${D}/usr install
    else
      try make prefix=${D}/usr install
    fi
}

