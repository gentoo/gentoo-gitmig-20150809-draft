# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/battstat/battstat-2.0.10.ebuild,v 1.1 2001/07/31 08:28:57 hallski Exp $

A="battstat_applet-${PV}.tar.gz"
S=${WORKDIR}/battstat_applet-${PV}
DESCRIPTION="Battstat Applet, GNOME battery status applet."
SRC_URI="http://download.sourceforge.net/battstat/${A}"
HOMEPAGE="http://battstat.sourceforge.net"

DEPEND="virtual/glibc
	>=gnome-base/gnome-libs-1.2.0
	>=gnome-base/gnome-core-1.4.0
	>=sys-apps/apmd-3.0.1
	nls? ( sys-devel/gettext )"

src_compile() {
    local myconf

    if [ -z "`use nls`" ] ; then
        myconf="--disable-nls"
    fi

    cd ${S}

    try ./configure --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome \
	            --mandir=/opt/gnome/man $myconf

    try make

}

src_install () {

    try make DESTDIR=${D} install

    dodoc AUTHORS COPYING ChangeLog NEWS README TODO

}
