# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/bonobo-conf/bonobo-conf-0.9.ebuild,v 1.1 2001/07/27 20:48:21 hallski Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Bonobo Configuration System"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/bonobo-conf/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
	>=dev-libs/glib-1.2.0
	>=dev-util/xml-i18n-tools-0.8.4
	>=x11-libs/gtk+-1.2.0
	>=gnome-base/bonobo-1.0.7
	>=gnome-base/oaf-0.6.2"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome --disable-more-warnings $myconf
    try pmake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO

}





