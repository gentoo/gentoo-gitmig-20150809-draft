# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.4.ebuild,v 1.1 2001/02/02 19:49:09 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${A}"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND=">=media-gfx/gimp-1.2
	=media-gfx/sane-backends-1.0.4"

src_compile() {

    cd ${S}
    try ./configure --prefix=/usr/X11R6 \
		--datadir=/usr/X11R6/share/misc --host=${CHOST}
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/usr/X11R6 datadir=${D}/usr/X11R6/share/misc install
    dodir /usr/X11R6/lib/gimp/1.2/plug-ins
    dosym /usr/X11R6/bin/xscanimage /usr/X11R6/lib/gimp/1.2/plug-ins/xscanimage

    dodoc AUTHORS COPYING Changelog NEWS PROBLEMS README TODO
}

