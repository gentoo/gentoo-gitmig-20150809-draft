# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-1.4.0.1.ebuild,v 1.7 2001/08/31 22:54:33 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="The GNOME control-center"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext ) 
        >=dev-util/xml-i18n-tools-0.8.4
	>=gnome-base/gnome-vfs-1.0 
        >=media-libs/gdk-pixbuf-0.11.0"

RDEPEND=">=gnome-base/gnome-vfs-1.0 
         >=media-libs/gdk-pixbuf-0.11.0"

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} --prefix=/opt/gnome 		\
		    --sysconfdir=/etc/opt/gnome ${myconf} || die

	emake || die
}

src_install() {                               
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING* ChangeLog README NEWS
}





