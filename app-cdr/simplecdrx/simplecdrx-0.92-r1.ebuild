# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/simplecdrx/simplecdrx-0.92-r1.ebuild,v 1.1 2001/10/06 13:20:34 azarah Exp $

S=${WORKDIR}/${PN}
SRC_URI="http://ogre.rocky-road.net/files/${P}.tar.gz"

HOMEPAGE="http://ogre.rocky-road.net/cdr.shtml"
DESCRIPTION="CD ripping/mastering"

#todo: add blade encoder
DEPEND="sys-devel/gcc media-sound/mad app-cdr/cdrecord app-cdr/cdrdao 
		media-sound/cdparanoia media-sound/lame media-libs/libogg
		media-sound/mpg123 virtual/x11 >=x11-libs/gtk+-1.2.10-r4 \
		dev-libs/glib media-libs/libvorbis
		media-libs/libao"
RDEPEND="media-sound/mad app-cdr/cdrecord app-cdr/cdrdao 
		media-sound/cdparanoia media-sound/lame media-libs/libogg
		media-sound/mpg123 virtual/x11 >=x11-libs/gtk+-1.2.10-r4 \
		dev-libs/glib media-libs/libvorbis
		media-libs/libao"

src_compile() {
    
    confopts="--infodir=/usr/share/info --mandir=/usr/share/man --prefix=/usr --host=${CHOST}"
    
    try ./configure ${confopts}
    
    try emake

}

src_install () {

    try make DESTDIR=${D} install

}

