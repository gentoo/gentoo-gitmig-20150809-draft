# Copyright 1999-2003 Gentoo Technologies, Inc.                                                                                         
# Distributed under the terms of the GNU General Public License v2                                                                      
# $Header: /var/cvsroot/gentoo-x86/media-video/mtxdrivers-pro/mtxdrivers-pro-1.0_beta4.ebuild,v 1.2 2003/06/06 17:38:17 prez Exp $                     

At="mtxdrivers-pro-rh9.0-beta4.tar.gz"
S="${WORKDIR}/mtxdrivers-pro-RH9.0-beta4"
SRC_URI=""
DESCRIPTION="Drviers for the Matrox Parhelia and Millenium P650/P750 cards with GL suport."
HOMEPAGE="http://www.matrox.com/mga/products/parhelia/home.cfm"

DEPEND=">=x11-base/xfree-4.2.0
	virtual/kernel
	opengl-update"

SLOT="0"
LICENSE="Matrox"
KEYWORDS="~x86"

Xversion=`X -version 2>&1 | grep -s "XFree86 Version" | cut -d" " -f3 | sed -e "s/\([^\.]*\.[^\.]*\.[^\.]*\)\.[^\.]*/\1/"`
GLversion="1.3.0"

src_unpack() {
    if [ ! -f "${DISTDIR}/${At}" ]; then
		einfo "Matrox requires you email them for the 'pro' version of their drivers"
		einfo "(ie. the ones with GL support).  If you do not need GL support, please"
		einfo "emerge mtxdrivers, otherwise e-mail cad-support@matrox.com and request"
		einfo "the Matrox Parhelia drivers with GL support.  Please remember to"
		einfo "download the RH9.0 driver, once you are given the site address."
		die
    fi
	unpack ${At}
}

src_compile() {
	cd ${S}

	if [ ! -e ${S}/xfree86/${Xversion} ]; then
		eerror "Matrox does not support XFree v${Xversion}"
		exit 1
	fi

	export PARHELIUX=$PWD/src
	cd ${S}/src/kernel/parhelia
	ln -sf ../../../kernel/mtx_parhelia.o .
	cd ..
	# Can't use emake here
	make clean
	make
}

src_install() {
	cd ${S}

	Xpath="`which X | sed -e "s:/bin/X$::"`"
	Kversion=`uname -r`

	dodir /lib/modules/${Kversion}/kernel/drivers/video
	dodir /usr/include/GL ${Xpath}/lib/modules/drivers
	dodir /usr/lib/opengl/mtx/extensions
    dodir /usr/lib/opengl/mtx/lib /usr/lib/opengl/mtx/include

	dodoc README* samples/*

	# Kernel Module
	install -m 755 ${S}/src/kernel/mtx.o ${D}/lib/modules/${Kversion}/kernel/drivers/video

	# X Driver (2D)
	install -m 755 ${S}/xfree86/${Xversion}/mtx_drv.o ${D}/${Xpath}/lib/modules/drivers

	# OpenGL
	install -m 755 ${S}/xfree86/${Xversion}/libglx.a ${D}/usr/lib/opengl/mtx/extensions
	install -m 644 ${S}/include/GL/gl.h ${D}/usr/lib/opengl/mtx/include
	install -m 644 ${S}/include/GL/glx.h ${D}/usr/lib/opengl/mtx/include
	install -m 644 ${FILESDIR}/glext.h ${D}/usr/include/GL
	install -m 755 ${S}/lib/libGL.so.${GLversion} ${D}/usr/lib/opengl/mtx/lib
	cd ${D}/usr/lib/opengl/mtx/lib
	ln -s libGL.so.${GLversion} libGL.so.1
	ln -s libGL.so.${GLversion} libGL.so
}

pkg_postinst() {
    /sbin/depmod -a
    /sbin/ldconfig
	opengl-update mtx
	einfo "Please look at /usr/share/doc/${P}/XF86Config.* for"
	einfo "X configurations for your Parhelia or Millenium P650/P750 card."
	if [ ! -d /dev/video ]; then
		if [ -f /dev/video ]; then
			einfo "NOTE: To be able to use busmastering (required for GL) , you MUST"
			einfo "      have /dev/video as a directory, which means you must remove"
		    einfo "      anything there first (rm -f /dev/video), and mkdir /dev/video"
		else
			mkdir /dev/video
		fi
	fi
}
