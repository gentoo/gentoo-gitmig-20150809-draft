# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkDPS/gtkDPS-0.3.3.ebuild,v 1.4 2001/06/04 03:33:03 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Set of functions, objects and widgets to use DPS easily with GTK"
SRC_URI="http://www.aist-nara.ac.jp/~masata-y/gtkDPS/dist/${A}"
HOMEPAGE="http://www.aist-nara.ac.jp/~masata-y/gtkDPS/"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )
	>=x11-libs/gtk+-1.2.8
	>=app-text/dgs-0.5.9.1"
RDEPEND="virtual/glibc"

src_compile() {
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi

    try ./configure --prefix=/usr/X11R6 --host=${CHOST} \
	--with-x --with-dps $myconf
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 install
    dodoc COPYING* ChangeLog GTKDPS-VERSION HACKING NEWS README TODO
}

