# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authour: Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-0.11.1-r1.ebuild,v 1.4 2001/08/23 11:09:00 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="sys-devel/gettext
	>=gnome-base/gal-0.6
	>=gnome-base/control-center-1.2.4
        >=gnome-base/libghttp-1.0.9
        >=gnome-base/libunicode-0.4
	>=gnome-base/bonobo-1.0.4
	>=gnome-base/gconf-1.0.1
        >=dev-util/xml-i18n-tools-0.8.4"

RDEPEND=">=gnome-base/gal-0.5
	 >=gnome-base/control-center-1.2.4
         >=gnome-base/libghttp-1.0.9
         >=gnome-base/libunicode-0.4
	 >=gnome-base/gconf-1.0.1
         >=gnome-base/bonobo-1.0.4"


src_compile() {

        local myconf

#        if [ -z "`use nls`" ]
#        then
#                myconf="--disable-nls"
#        fi

  	try  ./configure --host=${CHOST} --prefix=/opt/gnome \
		 --sysconfdir=/etc/opt/gnome --with-bonobo \
	         --with-gconf ${myconf}

  	try emake
}

src_install() {

	try make DESTDIR=${D} install
  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO

}













