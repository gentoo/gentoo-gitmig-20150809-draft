# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/bcast-2000/bcast-2000a-r1.ebuild,v 1.4 2000/10/29 20:37:00 achim Exp $

P=bcast-2000a
A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Realtime audio and video editor"
SRC_URI="http://heroine.linuxave.net/${A}"
HOMEPAGE="http://heroine.linuxave.net/bcast2000.html"

src_unpack() {
  unpack ${A}
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
    insinto /usr/X11R6/lib/bcast2000a/plugins
    doins plugins/*.plugin
    dodoc COPYING
    docinto html
    dodoc docs/*.html docs/*.png docs/*.jpg
    	

}



