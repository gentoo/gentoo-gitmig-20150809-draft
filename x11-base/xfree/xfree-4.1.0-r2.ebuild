# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-base/xfree/xfree-4.1.0-r2.ebuild,v 1.5 2001/09/17 19:32:45 woodchip Exp $

A="X410src-1.tgz X410src-2.tgz X410src-3.tgz truetype.tar.gz"
S=${WORKDIR}/xc
DESCRIPTION="Xfree86: famouse and free X server"
SRC_PATH0="ftp://ftp.xfree.org/pub/XFree86/4.1.0/source"
SRC_PATH1="ftp://ftp1.sourceforge.net/pub/mirrors/XFree86/4.1.0/source"

SRC_URI="$SRC_PATH0/X410src-1.tgz $SRC_PATH0/X410src-2.tgz $SRC_PATH0/X410src-3.tgz
	 $SRC_PATH1/X410src-1.tgz $SRC_PATH1/X410src-2.tgz $SRC_PATH1/X410src-3.tgz
       	 http://www.ibiblio.org/gentoo/gentoo-sources/truetype.tar.gz"

HOMEPAGE="http://www.xfree.org"

DEPEND=">=sys-libs/ncurses-5.1
        >=sys-libs/zlib-1.1.3-r2
        sys-devel/flex
        sys-devel/perl"
RDEPEND=">=sys-libs/ncurses-5.1"
PROVIDE="virtual/x11 virtual/opengl virtual/glu"

src_unpack () {
	unpack X410src-{1,2,3}.tgz
	cd ${S}
	cp ${FILESDIR}/${PVF}/site.def config/cf/host.def
	echo "#define DefaultGcc2i386Opt ${CFLAGS}" >>  config/cf/host.def
	echo "#define GccWarningOptions -Wno" >>  config/cf/host.def
	echo "#define DefaultCCOptions -ansi" >>  config/cf/host.def
}

src_compile() {
    make World || die
}

src_install() {

    make install DESTDIR=${D} || die
    make install.man DESTDIR=${D} || die

	#we zap the host.def file which gets hard-coded with our CFLAGS, messing up other things that use xmkmf
	echo > ${D}/usr/X11R6/lib/X11/config/host.def
	#theoretically, /usr/X11R6/lib/X11/config is a possible candidate for config file management.
	#If we find that people really worry about imake stuff, we may add it.  But for now, we leave
	#the dir unprotected.

    insinto /usr/X11R6/lib/X11
    doins ${FILESDIR}/${PVF}/XftConfig
    cd ${D}/usr/X11R6/lib/X11/fonts
    tar -xz --no-same-owner -f ${DISTDIR}/truetype.tar.gz
    dosym /usr/X11R6/lib/libGL.so.1.2 /usr/X11R6/lib/libMesaGL.so
	
	#X installs some /usr/lib/libGL symlinks, pointing to the libGL's in /usr/X11R6/lib.
	#I don't see the point in this.  Yes, according to LSB, the correct location for libGL is
	#in /usr/lib, but this is so closely integrated with X itself that /usr/X11R6/lib seems
	#like the right place.
	rm -rf ${D}/usr/lib    
	
	#dosym /usr/X11R6/lib/libGLU.so.1.3 /usr/lib/libMesaGLU.so
	#We're no longer including libGLU from here.  Packaged separately, from separate sources.
	
    insinto /etc/env.d
    doins ${FILESDIR}/${PVF}/10xfree
    insinto /etc/X11/xinit
    doins ${FILESDIR}/${PVF}/xinitrc
    insinto /etc/X11/xdm
    doins ${FILESDIR}/${PVF}/Xsession
    insinto /etc/pam.d
    doins ${FILESDIR}/${PVF}/xdm
    exeinto /etc/init.d
    newexe ${FILESDIR}/${PVF}/xdm.start xdm
}
