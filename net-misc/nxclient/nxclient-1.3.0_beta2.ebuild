# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="NXClient is a X11/VNC/NXServer client especially tuned for using remote desktops over low-bandwidth links such as the Internet"
HOMEPAGE="www.nomachine.com"

IUSE=""
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 -ppc -sparc -alpha -mips"
RESTRICT="nostrip"

# this ebuild deals with release 42 of NXClient 1.2.2
MY_PV="${PN}-1.3.0-30-beta2"
SRC_URI="http://www.nomachine.com/download/beta/nxclient-linux-binaries-beta2/${MY_PV}.i386.tar.gz"

DEPEND=">=media-libs/jpeg-6b-r3
	>=sys-libs/glibc-2.3.2-r1
	>=sys-libs/zlib-1.1.4-r1
	>=x11-base/xfree-4.3.0-r2
	>=net-misc/nxssh-1.3.0_beta2
	>=net-misc/nxproxy-1.3.0_beta2
	>=dev-libs/expat-1.95.6-r1
	>=media-libs/fontconfig-2.2.0-r2
	>=media-libs/freetype-2.1.4
	>=media-libs/jpeg-6b-r3"

S="${WORKDIR}/nxclient-install"

src_compile() {
	return;
}

src_install() {
	exeinto /usr/NX/bin
#	doexe NX/bin/nxartsdstatus
	doexe NX/bin/nxclient
#	doexe usr/NX/bin/nxproxy
#	doexe usr/NX/bin/nxssh

#	insinto /usr/NX/lib
#	dolib usr/NX/lib/libXcomp.so.1.2.2

	insinto /usr/NX/share
	doins NX/share/client.id_dsa.key
	insinto /usr/NX/share/icons
	doins NX/share/icons/*
	insinto /usr/NX/share/images
	doins NX/share/images/*.png

	insinto /etc/env.d
	doins ${FILESDIR}/1.2.2/50nxclient

	insinto /usr/kde/3.1/share/applnk/Internet
	doins "NX/share/applnk/NX Client for Linux/nxclient-admin.desktop"
	doins "NX/share/applnk/NX Client for Linux/nxclient-help.desktop"
	doins "NX/share/applnk/NX Client for Linux/nxclient-wizard.desktop"
	doins "NX/share/applnk/NX Client for Linux/nxclient.desktop"
}
