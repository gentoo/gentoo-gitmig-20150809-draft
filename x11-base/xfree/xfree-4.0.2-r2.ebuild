# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.0.2-r2.ebuild,v 1.1 2001/02/10 11:24:50 achim Exp $

A="X402src-1.tgz X402src-2.tgz X402src-3.tgz truetype.tar.gz gatos.tar.gz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree - 4.0.2 with Antialias support and ATI TV and Overlay support from the LiVID project"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/4.0.2/source"
SRC_PATH1="ftp://download.sourceforge.net/pub/mirrors/XFree86/4.0.2/source"
SRC_URI="$SRC_PATH0/X402src-1.tgz $SRC_PATH0/X402src-2.tgz $SRC_PATH0/X402src-3.tgz
	 $SRC_PATH1/X402src-1.tgz $SRC_PATH1/X402src-2.tgz $SRC_PATH1/X402src-3.tgz
       	 http://keithp.com/~keithp/fonts/truetype.tar.gz
         http://www.linuxvideo.org/devel/data/gatos.tar.gz"

HOMEPAGE="http://www.xfree.org
          http://www.linuxvideo.org/gatos/"

DEPEND=">=media-libs/freetype-2.0.1
	    >=sys-libs/glibc-2.1.3
	    >=sys-libs/ncurses-5.1"


src_unpack () {

  unpack ${A}
  cp ${FILESDIR}/${PV}/site.def ${S}/config/cf/host.def
  gzip -dc ${FILESDIR}/${PV}/${P}.dif.gz | patch -p0
  echo "#define DefaultGcc2i386Opt ${CFLAGS}" >>  ${S}/config/cf/host.def
  ( cd ${S}/programs/Xserver/hw/xfree86/loader; patch -p0 < ${WORKDIR}/gatos-ati/ati_xv/loader.patch )
  ( cd ${S}/programs/Xserver/hw/xfree86/i2c; patch -p1 < ${WORKDIR}/gatos-ati/ati_xv/i2c.patch )

}

src_compile() {

    try make World
    cd ${WORKDIR}/gatos-ati/ati_xv/ati.2
    export PATH=${S}/config/imake/bootstrap:$PATH
    try ${S}/config/util/xmkmf ${S}
    try make
}

src_install() {

    try make install DESTDIR=${D}
    try make install.man DESTDIR=${D} MANPATH=/usr/X11R6/share/man

    cd ${WORKDIR}/gatos-ati/ati_xv/ati.2

    try make install DESTDIR=${D}

    insinto /usr/X11R6/lib/X11
    doins ${FILESDIR}/${PV}/XftConfig
    cd ${D}/usr/X11R6/lib/X11/fonts
    tar xzf ${DISTDIR}/truetype.tar.gz
    preplib /usr/X11R6
    insinto /etc/env.d
    doins ${FILESDIR}/10xfree
    insinto /etc/X11/xinit
    doins ${FILESDIR}/xinitrc
    insinto /etc/X11/xdm
    doins ${FILESDIR}/Xsession

}




