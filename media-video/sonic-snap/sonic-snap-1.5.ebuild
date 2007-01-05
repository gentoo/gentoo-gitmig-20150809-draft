# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/sonic-snap/sonic-snap-1.5.ebuild,v 1.4 2007/01/05 20:41:01 flameeyes Exp $

inherit eutils linux-info

DESCRIPTION="Webcam app for sn9c10x based camera controllers (with optional MPEG4 support)"
HOMEPAGE="http://stolk.org/sonic-snap/"
SRC_URI="http://stolk.org/${PN}/${P}.tar.gz"

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="amd64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="mpeg"

DEPEND=" >=x11-libs/fltk-1.1.0_rc6
	mpeg? ( >=media-libs/libfame-0.9.1 )
	sys-libs/zlib
	virtual/libc
	|| ( ( x11-libs/libXdmcp
	    x11-libs/libXau
	    x11-libs/libXrender
	    x11-libs/libX11
	    x11-libs/libXext
	    x11-libs/libXft )
	    virtual/x11 )"

CONFIG_CHECK="USB_SN9C102"
ERROR_USB_SN9C102="Please make sure Device Drivers -> USB Support -> SN9C10x \
PC Camera Controller support, and Device Drivers -> Video For Linux support \
are enabled as modules in your kernel."

src_unpack() {
	unpack ${A}
	cd ${S}
	use mpeg && sed -i -e "s?USE_FAME=0?USE_FAME=1?g" Makefile
}

src_compile() {
	make || die '"make" failed.'
}

src_install() {
	dodir /usr/bin
	make DESTDIR=${D} install || die '"make install" failed.'
	#einstall || die "einstall failed"

	dodoc ChangeLog README
	doman debian/sonic-snap.1
}

pkg_postinst() {

	ewarn
	elog "This application has found the sn9c10x driver (sn9c102.ko)"
	elog "enabled in the USB section of your kernel config.  Also,"
	elog "this driver is V4L v2 only, so V4L v1 apps will not work."
	elog "Finally, only a few image sensors are supported, eg, PAS106B"
	elog "so (check dmesg or /var/log/messages for USB device info when"
	elog "you plug the cam in)."
	elog
	elog "Now try sonic-snap-gui /dev/videoX (where X is 0, 1 , etc)."
	ewarn
}
