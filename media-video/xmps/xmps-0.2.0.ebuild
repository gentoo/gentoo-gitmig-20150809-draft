# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xmps/xmps-0.2.0.ebuild,v 1.3 2001/06/21 20:15:00 lamer Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X Movie Player System"
SRC_URI="http://xmps.sourceforge.net/sources/${A}"
HOMEPAGE="http://xmps.sourceforge.net"

DEPEND=">=media-libs/smpeg-0.4.1 nls? ( sys-devel/gettext )
	>=dev-lang/nasm-0.98
        >=dev-libs/popt-1.5
        >=x11-libs/gtk+-1.2.10
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

RDEPEND=">=media-libs/smpeg-0.4.1
        >=x11-libs/gtk+-1.2.10
        >=dev-libs/popt-1.5
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

src_compile() {

    local myopts
    if [ -n "`use gnome`" ]
    then
	myopts="--enable-gnome --prefix=/opt/gnome"
    else
	myopts="--disable-gnome --prefix=/usr/X11R6"
    fi
    if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
    fi
    try ./configure ${myopts} --host=${CHOST}
    cp Makefile Makefile.orig
    sed -e "s:\$(bindir)/xmps-config:\$(DESTDIR)\$(bindir)/xmps-config:" \
	Makefile.orig > Makefile
    try make

}

src_install () {

    if [ -n "`use gnome`" ]
    then
      try make prefix=${D}/opt/gnome install
    else
      try make prefix=${D}/usr/X11R6 install
    fi
    dodoc AUTHORS ChangeLog COPYING NEWS README TODO

}



