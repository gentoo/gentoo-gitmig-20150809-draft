# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/glib/glib-1.2.10.ebuild,v 1.2 2001/06/11 08:11:28 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v1.2/${A}
	 ftp://ftp.gnome.org/pub/GNOME/stable/sources/glib/${A}
	 http://ftp.gnome.org/pub/GNOME/stable/sources/glib/${A}"
HOMEPAGE="http://www.gtk.org/"

DEPEND="virtual/glibc"

src_compile() {
    local myconf
    
    if [ "${DEBUG}" ]
    then
	myconf="--enable-debug=yes"
    else
	myconf="--enable-debug=no"
    fi
    
    try ./configure --host=${CHOST} --prefix=/usr \
	--infodir=/usr/share/info \
	--mandir=/usr/share/man  \
	--with-threads=posix ${myconf}
    try pmake
}

src_install() {
    try make install DESTDIR=${D}
    
    dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
    cd docs
    docinto html
    dodoc glib.html glib_toc.html
}





