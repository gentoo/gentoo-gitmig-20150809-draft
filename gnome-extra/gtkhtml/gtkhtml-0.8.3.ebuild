# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-0.8.3.ebuild,v 1.1 2001/04/15 18:57:14 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gtkhtml"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/gtkhtml/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=gnome-base/gal-0.5
	 >=gnome-base/gconf-1.0
	 >=gnome-base/control-center-1.2.4
	 >=gnome-base/glibwww-0.2-r1
         >=gnome-base/libghttp-1.0.9"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.4"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p1 < ${FILESDIR}/${P}-gentoo.diff
#    try aclocal -I macros
#    try autoconf
    try automake
}

src_compile() {

        local myconf

        if [ -z "`use nls`" ]
        then
                myconf="--disable-nls"
        fi

        if [ "`use bonobo`" ]
        then
            myconf="${myconf} --with-bonobo"
        else
            myconf="${myconf} --without-bonobo"
        fi

  	try  ./configure --host=${CHOST} --prefix=/opt/gnome \
		 --sysconfdir=/etc/opt/gnome ${myconf} --with-gconf

  	try make
}

src_install() {

	try make DESTDIR=${D} install
	#insinto /opt/gnome/include/gtkhtml
	#doins src/htmlurl.h
  	dodoc AUTHORS COPYING* ChangeLog README
  	dodoc NEWS TODO

}













