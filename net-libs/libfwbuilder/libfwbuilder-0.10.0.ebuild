# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-libs/libfwbuilder/libfwbuilder-0.10.0.ebuild,v 1.3 2002/05/27 17:27:39 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/fwbuilder/$A"
HOMEPAGE="http://fwbuilder.sourceforge.net"

DEPEND=">=dev-libs/libsigc++-1.0.4
	>=dev-libs/libxslt-1.0.7-r1"

src_compile() {

    ./configure --prefix=/usr --host=${CHOST} || die
    if [ "`use static`" ] ; then
        make LDFLAGS="-static" || die
    else
        make || die
    fi

}

src_install () {

    make DESTDIR=${D} install || die
    prepalldocs

}

