# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/pharmacy/pharmacy-0.3.ebuild,v 1.1 2001/06/15 19:18:12 blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Front-End to CVS"
SRC_URI="http://prdownloads.sourceforge.net/pharmacy/${A}"
HOMEPAGE="http://pharmacy.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.2.13"

src_compile() {

    try ./configure --prefix=/opt/gnome --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
    insinto /opt/gnome/doc/pharmacy/index
    doins docs/index/* 
	 insinto /opt/gnome/doc/pharmacy  docs/index.sgml
}

