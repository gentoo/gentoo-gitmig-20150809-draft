# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-office/dia/dia-0.88.1.ebuild,v 1.2 2001/06/05 19:43:20 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

DEPEND=">=gnome-base/libxml-1.8.13 nls? ( sys-devel/gettext )
        >=gnome-base/gdk-pixbuf-0.11.0
        >=app-arch/rpm-3.0.6
	bonobo? ( >=gnome-base/bonobo-1.0.4 )
	python? ( dev-lang/python-2.0 )"
RDEPEND=">=gnome-base/libxml-1.8.13
        >=gnome-base/gdk-pixbuf-0.11.0
        >=app-arch/rpm-3.0.6
	bonobo? ( >=gnome-base/bonobo-1.0.4 )"

src_compile() {

    local myconf
    local myprefix
    myprefix="--prefix=/usr/X11R6 --sysconfdir=/etc/X11"
    if [ "`use gnome`" ] ; then
        myconf="--enable-gnome"
        myprefix="--prefix=/opt/gnome --sysconfdir=/etc/opt/gnome"
    else
        myconf=""
    fi

    if [ "`use bonobo`" ]; then
      myconf="--enable-gnome --enable-bonobo"
    fi
#    if [ "`use python`" ] ; then
#      myconf="$myconf --with-python"
#    fi
    if [ -z "`use nls`" ] ; then
        myconf="$myconf --disable-nls"
    fi
    try ./configure --host=${CHOST} ${myprefix} ${myconf}
        # enable-gnome-print not recoomended
    try make

}

src_install () {
    myprefix="prefix=${D}/usr/X11R6 sysconfdir=${D}/etc/X11"
    if [ "`use gnome`" ] ; then
        myconf="--enable-gnome"
        myprefix="prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome"
    fi
    try make $myprefix install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS

}





