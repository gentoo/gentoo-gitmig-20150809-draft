# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/evolution/evolution-0.5.1.ebuild,v 1.2 2000/11/03 17:47:44 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="evolution"
SRC_URI="http://www.helixcode.com/apps/evolution-preview/${A}"
HOMEPAGE="http://"

DEPEND=">=gnome-base/gtkhtml-0.6.1
	>=gnome-base/gnome-core-1.2.2.1
	>=gnome-base/gnome-vfs-0.3.1
	>=gnome-libs/libunicode-0.4
	>=net-nds/openldap-1.2.11"

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

