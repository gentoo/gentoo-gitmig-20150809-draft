# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-misc/fwbuilder/fwbuilder-0.9.1.ebuild,v 1.1 2001/07/10 08:16:04 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION=""
SRC_URI="http://prdownloads.sourceforge.net/fwbuilder/$A"
HOMEPAGE="http://fwbuilder.sourceforge.net"

DEPEND=">=x11-libs/gtkmm-1.0.0
	gnome-libs/libxslt
	gnome-base/gnome-core"

src_compile() {

    try ./configure --prefix=/opt/gnome --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install

}

