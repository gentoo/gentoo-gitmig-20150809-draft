# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/linuxwacom/linuxwacom-0.6.0.ebuild,v 1.3 2004/04/07 21:02:01 spyderous Exp $

DESCRIPTION="Input driver for Wacom tablets and drawing devices"
HOMEPAGE="http://linuxwacom.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="|| ( >=x11-base/xfree-4.3.0-r6 x11-base/xorg-x11 )"

pkg_setup() {
	if [ ! "`grep sdk /var/db/pkg/x11-base/xfree-[0-9]*/USE`" ]
	then
		eerror "This package builds against the XFree86 SDK, and therefore requires"
		eerror "that you have emerged xfree with the sdk USE flag enabled."
		die "Please remerge xfree with the sdk USE flag enabled."
	fi
}

src_unpack() {
	unpack ${A}

	# Simple fixes to configure to check the actual location of the XFree86 SDK
	cd ${S}
	sed -i -e "s:XF86SUBDIR=.*:XF86SUBDIR=include:" configure
	sed -i -e "s:XF86V3SUBDIR=.*:XF86V3SUBDIR=include:" configure
}

src_compile() {
	myconf="--enable-wacomdrv --enable-wacomdrvv3 --with-xf86=/usr/X11R6/lib/Server \
		--with-xf86v3=/usr/X11R6/lib/Server"
	econf ${myconf} || die "configure failed."

	# Makefile fix for build against SDK
	cd ${S}/src
	cp Makefile Makefile.orig
	sed -i -e "s:XF86_DIR = .*:XF86_DIR = /usr/X11R6/lib/Server:" Makefile
	sed -i -e "s:XF86_V3_DIR = .*:XF86_V3_DIR = /usr/X11R6/lib/Server:" Makefile
	sed -i -e "s:/include/extensions:/include:g" Makefile
	cd ${S}

	emake || die "build failed."
}

src_install() {
	emake DESTDIR=${D} install || die "Install failed."
}
