# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsigc++/libsigc++-1.0.3.ebuild,v 1.1 2001/06/14 14:41:32 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GLib library of C routines"
SRC_URI="http://prdownloads.sourceforge.net/libsigc/${A}"
HOMEPAGE="http://libsigc.sourceforge.net/"

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
	--mandir=/usr/share/man  ${myconf}
    try make
}

src_install() {
    try make install DESTDIR=${D}
    
    dodoc AUTHORS ChangeLog COPYING README* INSTALL NEWS
}





