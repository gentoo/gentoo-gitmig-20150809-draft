# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.86.ebuild,v 1.5 2000/10/14 12:30:11 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"


src_compile() {

    cd ${S}
    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--with-catgets --enable-gnome --enable-gnome-print
    # bonobo support does not work yet
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
    prepman /opt/gnome
}



