# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/googleearth/googleearth-4_beta.ebuild,v 1.3 2006/06/13 05:50:45 tester Exp $

inherit eutils

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
SRC_URI="http://dl.google.com/earth/GE4/GoogleEarthLinux.bin"

LICENSE="googleearth MIT X11 SGI-B-1.1 openssl as-is ZLIB"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror"
IUSE=""

RDEPEND="x86? (
	media-libs/fontconfig
	media-libs/freetype
	virtual/opengl
	|| ( ( x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXft
		x11-libs/libXrender )
		virtual/x11 ) )
	amd64? (
	app-emulation/emul-linux-x86-xlibs
	app-emulation/emul-linux-x86-baselibs
	|| (
		>=app-emulation/emul-linux-x86-xlibs-7.0
		>=media-video/nvidia-glx-1.0.6629-r3
		>=x11-drivers/ati-drivers-8.8.25-r1 ) )"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} . || die "make_wrapper failed"

	doicon ${PN}-icon.png
	make_desktop_entry ${PN} "Google Earth" ${PN}-icon.png

	dodoc README.linux

	cd bin
	tar xpf ${WORKDIR}/${PN}-linux-x86.tar
	exeinto /opt/${PN}
	doexe *

	cd ${D}/opt/${PN}
	tar xpf ${WORKDIR}/${PN}-data.tar
}
