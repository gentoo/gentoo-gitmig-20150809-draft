# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.0.1-r2.ebuild,v 1.1 2002/06/25 10:26:11 bangert Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Napster Client using GTK"
SRC_URI="http://download.sourceforge.net/lopster/${A}"
HOMEPAGE="http://lopster.sourceforge.net"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )
	=x11-libs/gtk+-1.2*
        virtual/x11"

RDEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
        virtual/x11"

src_compile() {
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --prefix=/usr --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} gnulocaledir=/usr/share/locale install
    dodoc AUTHORS BUGS COPYING README ChangeLog NEWS
}

