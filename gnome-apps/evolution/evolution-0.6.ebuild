# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.6.ebuild,v 1.2 2000/10/31 05:23:49 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A GNOME groupware application, a Microsoft Outlook workalike"
SRC_URI="http://www.helixcode.com/apps/evolution-preview/${A}"
HOMEPAGE="http://www.helixcode.com"


src_compile() {

    cd ${S}
    try ./configure --prefix=/opt/gnome --host=${CHOST} --with-catgets
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog HACKING MAINTAINERS
    dodoc NEWS README
}

