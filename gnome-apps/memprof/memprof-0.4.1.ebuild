# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <hallski@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/memprof/memprof-0.4.1.ebuild,v 1.1 2001/06/28 23:42:13 hallski Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="MemProf - Profiling and leak detection"
SRC_URI="http://people.redhat.com/otaylor/memprof/${A}"
HOMEPAGE="http://people.redhat.com/otaylor/memprof/"

DEPEND="nls? ( sys-devel/gettext )
	gnome-base/gnome-libs
	sys-devel/binutils
	>=gnome-base/libglade-0.7"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome --disable-more-warnings $myconf
    try pmake

}

src_install () {

#    try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
    try make DESTDIR=${D} install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO

}





