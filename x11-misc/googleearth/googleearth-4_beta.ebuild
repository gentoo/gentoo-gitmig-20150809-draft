# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/googleearth/googleearth-4_beta.ebuild,v 1.2 2006/06/13 01:11:45 genstef Exp $

inherit eutils

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
SRC_URI="http://dl.google.com/earth/GE4/GoogleEarthLinux.bin"

LICENSE="googleearth MIT X11 SGI-B-1.1 openssl as-is ZLIB"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="mirror"
IUSE=""

RDEPEND="media-libs/fontconfig
	media-libs/freetype
	virtual/opengl
	|| ( ( x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXrender )
	virtual/x11
	)"

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
