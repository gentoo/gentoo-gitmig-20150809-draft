# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.8.ebuild,v 1.1 2000/12/21 19:19:19 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.helixcode.com"

DEPEND=""

src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/gnome --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}


