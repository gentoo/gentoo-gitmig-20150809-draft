# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/bcast-2000/bcast-2000b-r2.ebuild,v 1.1 2000/12/08 19:02:39 achim Exp $

A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Realtime audio and video editor"
SRC_URI="http://heroine.linuxave.net/${A}"
HOMEPAGE="http://heroine.linuxave.net/bcast2000.html"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-devel/gcc-2.95.2
	>=media-sound/esound-0.2.19
	>=media-libs/jpeg-6b
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	>=x11-base/xfree-4.0.1"

src_unpack() {
  unpack ${A}
  cd ${S}/bcast
  cp main.C main.C.orig
  sed -e "s:/usr/local/bcast/plugins:/usr/X11R6/lib/bcast/plugins:" \
	main.C.orig > main.C
  cd ${S}/esound
  cp esd.h esd.h.orig 
  sed -e "s:<audiofile\.h>:\"\.\./audiofile/audiofile\.h\":" esd.h.orig > esd.h
  cd ${S}/quicktime/libdv
  cp dvprivate.h dvprivate.h.orig
  sed -e "s:<libraw1394/raw1394\.h>:\"\.\./\.\./libraw1394/raw1394\.h\":" dvprivate.h.orig > dvprivate.h
}
src_compile() {

    cd ${S}
    try ./configure
    try make

}

src_install () {

    cd ${S}
    into /usr
    dobin bcast/bcast2000
    dolib.so bcbase/libbcbase.so
    insopts -m 755
    insinto /usr/X11R6/lib/bcast/plugins
    doins plugins/*.plugin
    dodoc COPYING
    docinto html
    dodoc docs/*.html docs/*.png docs/*.jpg
    	

}



