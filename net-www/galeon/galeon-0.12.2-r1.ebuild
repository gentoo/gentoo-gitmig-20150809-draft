# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/galeon/galeon-0.12.2-r1.ebuild,v 1.1 2001/10/06 14:36:55 azarah Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A small webbrowser for gnome that uses mozillas render engine"
SRC_URI="http://prdownloads.sourceforge.net/galeon/${A}"
HOMEPAGE="http://galeon.sourceforge.net"

DEPEND=">=net-www/mozilla-0.9.4-r2
	>=gnome-base/libglade-0.17-r1
	>=gnome-base/gnome-core-1.4.0.4-r1
	>=dev-libs/libxml-1.8.15
	>=gnome-base/gnome-vfs-1.0.2-r1
	>=gnome-base/gconf-1.0.4-r2
        >=dev-util/xml-i18n-tools-0.8.4
	>=gnome-base/oaf-0.6.6-r1
	nls? ( sys-devel/gettext )"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi

    ./configure --prefix=/usr --sysconfdir=/etc/gnome  			\
		--host=${CHOST}                                        	\
		--with-mozilla-libs=${MOZILLA_FIVE_HOME}		\
		--with-mozilla-includes=${MOZILLA_FIVE_HOME}/include	\
		$myconf

    assert "Configuration failed."

    emake || die
}

src_install () {
    gconftool --shutdown
    make DESTDIR=${D} install || die
    dodoc AUTHORS ChangeLog COPYING* FAQ NEWS README TODO THANKS
}
