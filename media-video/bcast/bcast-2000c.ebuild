# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/bcast/bcast-2000c.ebuild,v 1.4 2001/06/19 21:46:47 achim Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Realtime audio and video editor"
SRC_URI="ftp://heroines.sourceforge.net/pub/heroines/${A}"
HOMEPAGE="http://heroines.sourceforge.net/"

DEPEND="virtual/glibc dev-lang/nasm
	>=sys-devel/gcc-2.95.2
        >=dev-libs/glib-1.2.10
	>=media-libs/libpng-1.0.7
	virtual/x11"

RDEPEND="virtual/glibc
	>=sys-devel/gcc-2.95.2
        >=dev-libs/glib-1.2.10
	>=media-libs/libpng-1.0.7
	virtual/x11"

src_unpack() {
  unpack ${A}
  patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {

    try ./configure
    try make

}

src_install () {

    into /usr/X11R6
    dobin bcast/bcast2000
    dolib.so bcbase/libbcbase.so
    dolib.so guicast/libguicast.so
    insopts -m 755
    insinto /usr/X11R6/lib/bcast/plugins
    doins plugins/*.plugin
    dodoc COPYING
    docinto html
    dodoc docs/*.html docs/*.png docs/*.jpg

}



