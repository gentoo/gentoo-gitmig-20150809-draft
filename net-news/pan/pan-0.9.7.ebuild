# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Erik Van Reeth <erik@vanreeth.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.9.7.ebuild,v 1.5 2001/08/31 03:23:39 pm Exp $


A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="A newsreader for GNOME."
SRC_URI="http://pan.rebelbase.com/download/${PV}/${A}"
HOMEPAGE="http://pan.rebelbase.com/"

DEPEND="virtual/x11 nls? ( sys-devel/gettext )
	>=gnome-base/gnome-libs-1.0.16
        gtkhtml? ( >=gnome-base/gtkhtml-0.8.3 )"

src_compile() {
        local myconf
        if [ -z "`use nls`" ] ; then
          myconf="--disable-nls"
        fi
        if [ "`use gtkhtml`" ] ; then
          myconf="$myconf --enable-html"
        fi
	try ./configure --prefix=/opt/gnome $myconf
	try make   # Doesn't work with -j 4 (hallski)

}

src_install () {

	try make prefix=${D}/opt/gnome install
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO

}

