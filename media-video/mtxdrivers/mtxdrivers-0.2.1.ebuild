# Copyright 1999-2003 Gentoo Technologies, Inc.                                                                                         
# Distributed under the terms of the GNU General Public License v2                                                                      
# $Header: /var/cvsroot/gentoo-x86/media-video/mtxdrivers/mtxdrivers-0.2.1.ebuild,v 1.2 2003/04/20 01:27:45 prez Exp $                     

RELEASE=2002
SRC_URI="ftp://ftp.matrox.com/pub/mga/archive/linux/${RELEASE}/${P/-/_}.tgz"
DESCRIPTION="Drviers for the Matrox Parhelia card."
HOMEPAGE="http://www.matrox.com/mga/support/drivers/latest/home.cfm"

DEPEND=">=x11-base/xfree-4.1.0
	virtual/kernel"

SLOT="0"
LICENSE="Matrox"
KEYWORDS="x86"

Xversion=`X -version 2>&1 | grep -s "XFree86 Version" | cut -d" " -f3 | sed -e "s/\([^\.]*\.[^\.]*\.[^\.]*\)\.[^\.]*/\1/"`

src_unpack() {
	unpack ${A}
	mv mtxdrivers ${P}
}

src_compile() {
	cd ${S}

	# Patch because X 4.3.0 is 'not supported' but works.
	cp -a xfree86/4.2.1 xfree86/4.3.0

	if [ ! -e ${S}/xfree86/${Xversion} ]; then
		eerror "Matrox does not support XFree v${Xversion}"
	fi

	cd ${S}/kernel/src
	emake clean
	emake
}

src_install() {
	cd ${S}

	Xpath="`which X | sed -e "s:/bin/X$::"`"
	Kversion=`uname -r`

	dodir /usr/lib /lib/modules/${Kversion}/kernel/drivers/video ${Xpath}/lib/modules/drivers ${Xpath}/lib/modules/linux

	cp ${S}/xfree86/${Xversion}/mtx_drv.o ${D}/${Xpath}/lib/modules/drivers
	chmod 755 ${D}/${Xpath}/lib/modules/drivers/mtx_drv.o

	cp ${S}/lib/libparhl.so ${D}/usr/lib
	chmod 755 ${D}/usr/lib/libparhl.so
	ln -sf /usr/lib/libparhl.so ${D}${Xpath}/lib/modules/linux

	cp -a kernel/src/mtx.o ${D}/lib/modules/${Kversion}/kernel/drivers/video
	chmod 755 ${D}/lib/modules/${Kversion}/kernel/drivers/video/mtx.o

	dodoc README samples/*
}

pkg_postinst() {
	einfo "Please look at /usr/share/doc/${P}/XF86Config.*"
	einfo "for X configurations for your Parhelia card."
}
