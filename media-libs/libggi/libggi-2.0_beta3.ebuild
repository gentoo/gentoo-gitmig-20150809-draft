# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/libggi/libggi-2.0_beta3.ebuild,v 1.3 2001/05/01 18:29:06 achim Exp $

P=${PN}-2.0b3
A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Fast and safe graphics and drivers for about any graphics card to the Linux kernel (sometimes)"
SRC_URI="ftp://ftp.ggi-project.org/pub/ggi/ggi/2_0_beta_3/${A}"
HOMEPAGE="http://www.ggi-project.org/"

DEPEND="virtual/glibc
        >=media-libs/libgii-0.7
        X? ( virtual/x11 )
        svga? ( >=media-libs/svgalib-1.4.2 )
        aalib? ( >=media-libs/aalib-1.2-r1 )"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/glibc-2.2.2-speed.diff
}
src_compile() {

    local myconf
    if [ -z "`use X`" ]
    then
      myconf="--without-x"
    fi

    if [ -z "`use svga`" ]
    then
      myconf="$myconf --disable-svga --disable-vgagl"
    fi

    if [ -z "`use fbcon`" ]
    then
      myconf="$myconf --disable-fbdev"
    fi

    if [ -z "`use aalib`" ]
    then
      myconf="$myconf --disable-aa"
    fi

    try ./configure --prefix=/usr --sysconfdir=/etc --mandir=/usr/share/man --host=${CHOST} $myconf
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    #This la file seems to bug mesa
    rm ${D}/usr/lib/*.la

    dodoc ChangeLog* FAQ NEWS README
    docinto txt
    dodoc doc/*.txt
    docinto docbook
    dodoc doc/docbook/*.{dsl,sgml}

}

