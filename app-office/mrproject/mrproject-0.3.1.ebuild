# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>
# $Header: /var/cvsroot/gentoo-x86/app-office/mrproject/mrproject-0.3.1.ebuild,v 1.2 2001/07/29 10:29:28 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Project management application for GNOME"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${A}"
HOMEPAGE="http://mrproject.codefactory.se/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/gal-0.7
	>=gnome-base/bonobo-1.0.0
	>=dev-util/xml-i18n-tools-0.8.4
	>=media-libs/gdk-pixbuf-0.8.0
	>=gnome-base/libglade-0.14
	>=gnome-base/libxml-1.8.10
	>=gnome-base/gnome-vfs-1.0.0
	>=gnome-base/oaf-0.6.5
	>=gnome-base/gnome-print-0.25"

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

#    try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO

}





