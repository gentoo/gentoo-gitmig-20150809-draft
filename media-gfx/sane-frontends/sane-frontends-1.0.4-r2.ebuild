# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sane-frontends/sane-frontends-1.0.4-r2.ebuild,v 1.1 2001/10/06 15:30:16 danarmak Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Scanner Access Now Easy"
SRC_URI="ftp://ftp.mostang.com/pub/sane/${A}"
HOMEPAGE="http://www.mostang.com/sane/"

DEPEND=">=media-gfx/gimp-1.2
	>=media-gfx/sane-backends-1.0.4"

src_compile() {

    try ./configure --prefix=/usr --mandir=/usr/man \
		--datadir=/usr/share/misc --host=${CHOST}
    try make

}

src_install () {

    try make prefix=${D}/usr datadir=${D}/usr/share/misc \
	mandir=${D}/usr/man install
    dodir /usr/lib/gimp/1.2/plug-ins
    dosym /usr/bin/xscanimage /usr/lib/gimp/1.2/plug-ins/xscanimage

    dodoc AUTHORS COPYING Changelog NEWS PROBLEMS README TODO
}

