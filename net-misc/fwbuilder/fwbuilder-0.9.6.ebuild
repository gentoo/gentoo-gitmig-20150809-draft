# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/fwbuilder/fwbuilder-0.9.6.ebuild,v 1.4 2002/07/11 06:30:48 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/fwbuilder/$A"
HOMEPAGE="http://fwbuilder.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=x11-libs/gtkmm-1.2.5-r1
	>=dev-libs/libxslt-1.0.1
	>=net-libs/libfwbuilder-0.10.0
	>=gnome-base/gnome-libs-1.4"

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

