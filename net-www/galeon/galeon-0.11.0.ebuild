# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-0.11.0.ebuild,v 1.1 2001/06/09 08:57:39 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://prdownloads.sourceforge.net/galeon/${A}"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND=">=net-www/mozilla-0.9.1
	>=gnome-apps/glade-0.6.2
	>=gnome-base/gnome-core-1.4.0
        >=dev-util/xml-i18n-tools-0.8.4
	nls? ( sys-devel/gettext )"

RDEPEND=">=net-www/mozilla-0.9
	>=gnome-apps/glade-0.6.2
        >=gnome-base/gnome-core-1.4.0"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome --host=${CHOST} \
	--with-mozilla-libs=/opt/mozilla \
	--with-mozilla-includes=/opt/mozilla/include $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}

