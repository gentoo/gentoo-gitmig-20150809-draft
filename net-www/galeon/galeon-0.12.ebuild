# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-0.12.ebuild,v 1.3 2001/09/24 15:11:15 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://prdownloads.sourceforge.net/galeon/${A}"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND="~net-www/mozilla-0.9.3
	>=gnome-base/libglade-0.13
	>=gnome-base/gnome-core-1.4.0
	>=gnome-base/libxml-1.8.13
	>=gnome-base/gnome-vfs-0.6.0
	>=gnome-base/gconf-1.0.4
        >=dev-util/xml-i18n-tools-0.8.4
	>=gnome-base/oaf-0.6.2
	nls? ( sys-devel/gettext )"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi

    ./configure --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome        \
		--host=${CHOST}                                        \
		--with-mozilla-libs=/opt/mozilla                       \
		--with-mozilla-includes=/opt/mozilla/include $myconf

    assert "Configuration failed."

    emake || die
}

src_install () {
    gconftool --shutdown
    make DESTDIR=${D} install || die
    dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}

