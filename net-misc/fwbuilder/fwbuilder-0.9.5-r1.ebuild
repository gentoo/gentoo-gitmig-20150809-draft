# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/fwbuilder/fwbuilder-0.9.5-r1.ebuild,v 1.1 2001/10/06 17:22:52 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A firewall GUI"
SRC_URI="http://prdownloads.sourceforge.net/fwbuilder/$A"
HOMEPAGE="http://fwbuilder.sourceforge.net"

DEPEND=">=x11-libs/gtkmm-1.2.5-r1
	>=dev-libs/libxslt-1.0.1
	>=gnome-base/gnome-core-1.4.0.4-r1"

src_compile() {
    
    try ./configure --prefix=/usr --host=${CHOST}
    cp config.h config.h.orig
    sed -e "s:#define HAVE_XMLSAVEFORMATFILE 1://:" config.h.orig > config.h
    if [ "`use static`" ] ; then
        try make LDFLAGS="-static"
    else
        try make
    fi

}

src_install () {

    try make DESTDIR=${D} install

}

