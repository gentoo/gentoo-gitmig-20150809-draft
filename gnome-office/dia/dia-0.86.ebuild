# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/dia/dia-0.86.ebuild,v 1.3 2000/08/17 15:37:33 achim Exp $

P=dia-0.86
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/dia/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"


src_compile() {

    cd ${S}
./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets
    make

}

src_install () {

    cd ${S}
    make prefix=${D}/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
    prepman /opt/gnome
}



