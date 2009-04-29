# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/googleearth/googleearth-5.0.11729.1014.ebuild,v 1.1 2009/04/29 18:55:44 caster Exp $

EAPI=2

inherit eutils fdo-mime

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
# no upstream versioning, version determined from help/about
# incorrect digest means upstream bump and a need for version bump
SRC_URI="http://dl.google.com/earth/client/current/GoogleEarthLinux.bin
			-> GoogleEarthLinux-${PV}.bin"

LICENSE="googleearth MIT X11 SGI-B-1.1 openssl as-is ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
IUSE=""

RDEPEND="x86? (
	media-libs/fontconfig
	media-libs/freetype
	virtual/opengl
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXinerama
	x11-libs/libXrender )
	amd64? (
	app-emulation/emul-linux-x86-xlibs
	app-emulation/emul-linux-x86-baselibs
	|| (
		>=app-emulation/emul-linux-x86-xlibs-7.0
		x11-drivers/nvidia-drivers
		<x11-drivers/ati-drivers-8.28.8 ) )
	media-fonts/ttf-bitstream-vera"

S="${WORKDIR}"

QA_TEXTRELS="opt/googleearth/libgps.so
opt/googleearth/libgooglesearch.so
opt/googleearth/libevll.so
opt/googleearth/librender.so
opt/googleearth/libinput_plugin.so
opt/googleearth/libflightsim.so
opt/googleearth/libcollada.so
opt/googleearth/libminizip.so
opt/googleearth/libauth.so
opt/googleearth/libbasicingest.so
opt/googleearth/libmeasure.so"

src_unpack() {
	unpack_makeself
	# make the postinst script only create the files; it's  installation
	# are too complicated and inserting them ourselves is easier than
	# hacking around it
	sed -i -e 's:$SETUP_INSTALLPATH/::' \
		-e 's:$SETUP_INSTALLPATH:1:' \
		-e "s:^xdg-desktop-icon.*$::" \
		-e "s:^xdg-desktop-menu.*$::" \
		-e "s:^xdg-mime.*$::" postinstall.sh
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} . || die "make_wrapper failed"
	./postinstall.sh
	insinto /usr/share/mime/packages
	doins ${PN}-mimetypes.xml
	domenu Google-${PN}.desktop
	doicon ${PN}-icon.png
	dodoc README.linux

	cd bin
	tar xf "${WORKDIR}"/${PN}-linux-x86.tar
	exeinto /opt/${PN}
	doexe *

	cd "${D}"/opt/${PN}
	tar xf "${WORKDIR}"/${PN}-data.tar

	fowners -R root:root /opt/${PN}
	fperms -R a-x,a+X /opt/googleearth/{xml,resources}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
