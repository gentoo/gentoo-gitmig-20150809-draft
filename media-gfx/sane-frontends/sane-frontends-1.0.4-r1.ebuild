# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.4-r1.ebuild,v 1.2 2001/06/04 06:41:14 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${A}"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND=">=media-gfx/gimp-1.2
	>=media-gfx/sane-backends-1.0.4"

src_compile() {

    try ./configure --prefix=/usr/X11R6 --mandir=/usr/X11R6/man \
		--datadir=/usr/X11R6/share/misc --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr/X11R6 datadir=${D}/usr/X11R6/share/misc \
	mandir=${D}/usr/X11R6/man install
    dodir /usr/X11R6/lib/gimp/1.2/plug-ins
    dosym /usr/X11R6/bin/xscanimage /usr/X11R6/lib/gimp/1.2/plug-ins/xscanimage

    dodoc AUTHORS COPYING Changelog NEWS PROBLEMS README TODO
}

