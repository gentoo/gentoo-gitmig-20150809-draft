# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aaron Blew <moath@oddbox.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.7.ebuild,v 1.3 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Aumix volume/mixer control program."
SRC_URI="http://jpj.net/~trevor/aumix/${A}"
HOMEPAGE="http://jpj.net/~trevor/aumix/"

DEPEND="virtual/glibc
        >=sys-libs/ncurses-5.2
        >=sys-libs/gpm-1.19.3
        alsa? ( >=media-libs/alsa-lib-0.5.10 )
        gtk? ( >=x11-libs/gtk+-1.2.10 )
        nls? ( sys-devel/gettext )"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
        myconf="--disable-nls"
    fi
    if [ -z "`use gtk`" ] ; then
        myconf="$myconf --without-gtk"
    fi
    if [ -z "`use alsa`" ] ; then
        myconf="$myconf --without-alsa"
    fi

    try ./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO 
}

