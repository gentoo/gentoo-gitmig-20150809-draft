# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.0.3-r3.ebuild,v 1.11 2002/07/16 03:38:51 gerk Exp $

A="X402src-1.tgz X402src-2.tgz X402src-3.tgz 4.0.2-4.0.3.diff.gz truetype.tar.gz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree - 4.0.3 with Antialias support and ATI TV and Overlay support from the LiVID project"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/4.0.2/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/4.0.2/source"

SRC_URI="$SRC_PATH0/X402src-1.tgz $SRC_PATH0/X402src-2.tgz $SRC_PATH0/X402src-3.tgz
	 $SRC_PATH1/X402src-1.tgz $SRC_PATH1/X402src-2.tgz $SRC_PATH1/X402src-3.tgz
	 ftp://ftp.xfree.org/pub/XFree86/4.0.3/patches/4.0.2-4.0.3.diff.gz
	 ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/4.0.3/patches/4.0.2-4.0.3.diff.gz
       	 http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz"
#         http://www.linuxvideo.org/devel/data/gatos.tar.gz"

HOMEPAGE="http://www.xfree.org
          http://www.linuxvideo.org/gatos/"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86 -ppc"

DEPEND=">=sys-libs/ncurses-5.1
	>=sys-libs/zlib-1.1.3-r2
        >=sys-devel/flex-2.5.4a-r2
        sys-devel/perl"

RDEPEND=">=sys-libs/ncurses-5.1"

PROVIDE="virtual/x11 virtual/opengl"

src_unpack () {

  unpack X402src-{1,2,3}.tgz
  #gatos.tar.gz
  cd ${S}
  gzip -dc  ${DISTDIR}/4.0.2-4.0.3.diff.gz | patch -p1
  patch -p1 < ${FILESDIR}/${PV}/glibc-2.2.2-ClockP.diff
  cp ${FILESDIR}/${PV}/site.def config/cf/host.def
  echo "#define DefaultGcc2i386Opt ${CFLAGS}" >>  config/cf/host.def
  #( cd ${S}/programs/Xserver/hw/xfree86/loader; patch -p0 < ${WORKDIR}/gatos-ati/ati_xv/loader.patch )
  #( cd ${S}/programs/Xserver/hw/xfree86/i2c; patch -p1 < ${WORKDIR}/gatos-ati/ati_xv/i2c.patch )

}

src_compile() {

    try make World
    #cd ${WORKDIR}/gatos-ati/ati_xv/ati.2
    #export PATH=${S}/config/imake/bootstrap:$PATH
    #try ${S}/config/util/xmkmf ${S}
    #try make
}

src_install() {

    try make install DESTDIR=${D}
    try make install.man DESTDIR=${D}
	# MANPATH=/usr/X11R6/share/man

    #cd ${WORKDIR}/gatos-ati/ati_xv/ati.2

    #try make install DESTDIR=${D}

    insinto /usr/X11R6/lib/X11
    doins ${FILESDIR}/${PV}/XftConfig
    cd ${D}/usr/X11R6/lib/X11/fonts
    tar xzf ${DISTDIR}/truetype.tar.gz

    dosym /usr/X11R6/lib/libGL.so.1.2 /usr/lib/libMesaGL.so

    insinto /etc/env.d
    doins ${FILESDIR}/10xfree
    insinto /etc/X11/xinit
    doins ${FILESDIR}/xinitrc
    insinto /etc/X11/xdm
    doins ${FILESDIR}/Xsession
    insinto /etc/pam.d
    doins ${FILESDIR}/xdm
    exeinto /etc/rc.d/init.d
    newexe ${FILESDIR}/xdm.start xdm
}




