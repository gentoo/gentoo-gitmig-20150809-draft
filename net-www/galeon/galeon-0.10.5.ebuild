# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-0.10.5.ebuild,v 1.1 2001/05/06 19:13:29 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://prdownloads.sourceforge.net/galeon/${A}"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND=">=net-www/mozilla-0.8.1
	>=gnome-base/gnome-libs-1.2.12
	>=gnome-base/gnome-vfs-0.6.2
	>=gnome-base/gconf-0.50
	sys-devel/gettext"

src_compile() {

    try ./configure --prefix=/opt/gnome --host=${CHOST} \
	--with-mozilla-libs=/opt/mozilla \
	--with-mozilla-includes=/opt/mozilla/include
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}

