# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mtxdrivers/mtxdrivers-0.3.0.ebuild,v 1.9 2004/03/20 05:12:23 ferringb Exp $

At="mtxdrivers-rh9.0-0.3.0.run"
DESCRIPTION="Drviers for the Matrox Parhelia and Millenium P650/P750 cards."
HOMEPAGE="http://www.matrox.com/mga/products/parhelia/home.cfm"
#SRC_URI="${At}"

LICENSE="Matrox"
SLOT="0"
KEYWORDS="x86"
RESTRICT="fetch"

DEPEND=">=x11-base/xfree-4.2.0
	virtual/kernel
	!media-video/mtxdrivers-pro"

pkg_nofetch() {
	einfo "You must go to: http://www.matrox.com/mga/registration/home.cfm?refid=7667"
	einfo "(for the RH9.0 drivers) and log in (or create an account) to download the"
	einfo "Matrox Parhelia drivers. Remember to right-click and use Save Link As when"
	einfo "downloading the driver."
}

src_unpack() {
	mkdir ${S}
	cd ${S}
	tail -n 4434 "${DISTDIR}/${At}" | tar -xvzf -
}

src_compile() {
	Xversion=`X -version 2>&1 | grep -s "XFree86 Version" | cut -d" " -f3 | sed -e "s/\([^\.]*\.[^\.]*\.[^\.]*\)\.[^\.]*/\1/"`

	if [ ! -e ${S}/xfree86/${Xversion} ]; then
		eerror "Matrox does not support XFree v${Xversion}"
		die
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
	Xversion=`X -version 2>&1 | grep -s "XFree86 Version" | cut -d" " -f3 | sed -e "s/\([^\.]*\.[^\.]*\.[^\.]*\)\.[^\.]*/\1/"`

	Xpath="`which X | sed -e "s:/bin/X$::"`"
	Kversion=`uname -r`

	dodir /lib/modules/${Kversion}/kernel/drivers/video
	dodir ${Xpath}/lib/modules/drivers

	dodoc README* samples/*

	# Kernel Module
	install -m 755 ${S}/src/kernel/mtx.o ${D}/lib/modules/${Kversion}/kernel/drivers/video

	# X Driver (2D)
	install -m 755 ${S}/xfree86/${Xversion}/mtx_drv.o ${D}/${Xpath}/lib/modules/drivers
}

pkg_postinst() {
	/sbin/depmod -a
	einfo "Please look at /usr/share/doc/${P}/XF86Config.* for"
	einfo "X configurations for your Parhelia or Millenium P650/P750 card."
	if [ ! -d /dev/video ]; then
		if [ -f /dev/video ]; then
			einfo "NOTE: To be able to use busmastering, you MUST have /dev/video as"
		    einfo "a directory, which means you must remove anything there first"
			einfo "(rm -f /dev/video), and mkdir /dev/video"
		else
			mkdir /dev/video
		fi
	fi
}
