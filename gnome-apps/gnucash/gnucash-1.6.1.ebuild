# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/gnucash/gnucash-1.6.1.ebuild,v 1.2 2001/07/27 21:30:50 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A personal finance manager"
SRC_URI="http://download.sourceforge.net/gnucash/${A}"
HOMEPAGE="http://gnucash.sourceforge.net"

DEPEND=">=gnome-base/gnome-libs-1.2.4
	>=gnome-base/libxml-1.8.10
	>=gnome-base/gtkhtml-0.9.2
	>=gnome-base/gnome-print-0.25
	>=sys-devel/perl-5
	>=dev-lang/swig-1.3_alpha4
	>=dev-libs/slib-2.3.8
	>=dev-libs/g-wrap-1.1.5
	>=gnome-office/guppi-0.35.5
	>=gnome-base/gal-0.8
	nls? ( sys-devel/gettext )"

RDEPEND=">=gnome-base/gnome-libs-1.2.4
	>=gnome-base/libxml-1.8.10
	>=dev-libs/slib-2.3.8"

src_compile() {

    local myconf
    if [ -z "`use nls`" ] ; then
        myconf="--disable-nls"
    fi
    try ./configure --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome --mandir=/opt/gnome/man --host=${CHOST} $myconf
    try make # Doesn't work with make -j 4 (hallski)

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog NEWS README TODO


}


