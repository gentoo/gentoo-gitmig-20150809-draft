# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnucash/gnucash-1.4.7-r2.ebuild,v 1.4 2001/04/29 18:42:54 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A personal finance manager"
SRC_URI="http://download.sourceforge.net/gnucash/${A}"
HOMEPAGE="http://gnucash.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.2.4
	>=gnome-base/libxml-1.8.10
	>=sys-devel/perl-4
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/slib-2.3.8
	nls? ( sys-devel/gettext )"

src_compile() {

    local myconf
    if [ -z "`use nls`" ] ; then
        myconf="--disable-nls" 
    fi
    try ./configure --prefix=/opt/gnome --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS REDAME TODO
        

}


