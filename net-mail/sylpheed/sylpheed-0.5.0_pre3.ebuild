# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-mail/sylpheed/sylpheed-0.5.0_pre3.ebuild,v 1.2 2001/07/04 01:25:59 lordjoe Exp $

#P=
A=${PN}-0.5.0pre3.tar.bz2
S=${WORKDIR}/${PN}-0.5.0pre3
DESCRIPTION="A lightweight email client and newsreader"
SRC_URI="http://sylpheed.good-day.net/sylpheed/${A}"
HOMEPAGE="http://sylpheed.good-day.net"

DEPEND=">=x11-libs/gtk+-1.2
        >=media-libs/compface-1.4
	gnome? ( >=gnome-base/gdk-pixbuf-0.10 )
	nls? ( sys-devel/gettext )"

RDEPEND=">=x11-libs/gtk+-1.2
	gnome? ( >=gnome-base/gdk-pixbuf-0.10 )"

src_compile() {

    local myconf
#    if [ -z "`use gnome`" ] ; then
#	myconf="--disable-gdk-pixbuf --disable-imlib"
#    fi
    if [ -z "`use nls`" ] ; then
	myconf="$myconf --disable-nls"
    fi
    try ./configure --prefix=/usr/X11R6 --host=${CHOST} --enable-ipv6 $myconf
    try make

}

src_install () {

    try make prefix=${D}/usr manualdir=${D}/usr/share/doc/${PF}/html install
    dodoc AUTHORS COPYING ChangeLog* NEWS README* TODO*

}

