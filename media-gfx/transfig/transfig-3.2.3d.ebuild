# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/transfig/transfig-3.2.3d.ebuild,v 1.1 2001/06/21 23:31:49 michael Exp $

#P=
A=transfig.3.2.3d.tar.gz
S=${WORKDIR}/transfig.3.2.3d
DESCRIPTION=""
SRC_URI="http://www.xfig.org/xfigdist/${A}"
HOMEPAGE="http://www.xfig.org"

DEPEND="virtual/glibc
	>=x11-base/xfree-4.0
        >=media-libs/jpeg-6
	>=media-libs/libpng-1.0.9
	"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}.patch
}

src_compile() {
    try xmkmf
    try make Makefiles
    try make
}

src_install () {
    # gotta set up the dirs for it....
    dodir /usr/bin
    dodir /usr/sbin
    dodir /usr/share/man/man1
    dodir /usr/X11R6/lib/fig2dev

    #Now install it.
    try make DESTDIR=${D} install

    #Install docs
    dodoc README CHANGES LATEX.AND.XFIG NOTES
    doman doc/fig2dev.1
    doman doc/fig2ps2tex.1
    doman doc/pic2tpic.1

}

# vim: ai et sw=4 ts=4
