# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit rpm

DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="www.nomachine.com"

IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -alpha -mips"
RESTRICT="nostrip"

MY_PV="${PV}-37"
SRC_URI="http://www.nomachine.com/download/nxclient/RedHat-9.0/nxclient-${MY_PV}.i386.rpm"

DEPEND=">=media-libs/jpeg-6b-r3
	>=sys-libs/glibc-2.3.2-r1
	>=sys-libs/zlib-1.1.4-r1
	>=x11-base/xfree-4.3.0-r2
	>=net-misc/nxssh-1.3.0
	>=net-misc/nxproxy-1.3.0
	>=dev-libs/expat-1.95.6-r1
	>=media-libs/fontconfig-2.2.0-r2
	>=media-libs/freetype-2.1.4
	>=media-libs/jpeg-6b-r3"

S="${WORKDIR}"

src_compile() {
	return;
}

src_install() {
	exeinto /usr/NX/bin
	doexe usr/NX/bin/nxartsdstatus
	doexe usr/NX/bin/nxclient
#	doexe usr/NX/bin/nxproxy
#	doexe usr/NX/bin/nxssh

#	insinto /usr/NX/lib
#	dolib usr/NX/lib/libXcomp.so.1.2.2

	insinto /usr/NX/share
	doins usr/NX/share/client.id_dsa.key
	insinto /usr/NX/share/icons
	doins usr/NX/share/icons/*
	insinto /usr/NX/share/images
	doins usr/NX/share/images/*.png

	insinto /etc/env.d
	doins ${FILESDIR}/${PVR}/50nxclient

	insinto /usr/kde/3.1/share/applnk/Internet
	doins "usr/NX/share/applnk/NX Client for Linux/nxclient-admin.desktop"
	doins "usr/NX/share/applnk/NX Client for Linux/nxclient-help.desktop"
	doins "usr/NX/share/applnk/NX Client for Linux/nxclient-wizard.desktop"
	doins "usr/NX/share/applnk/NX Client for Linux/nxclient.desktop"
}
