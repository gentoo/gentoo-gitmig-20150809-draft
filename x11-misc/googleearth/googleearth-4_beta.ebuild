# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/googleearth/googleearth-4_beta.ebuild,v 1.7 2006/07/07 20:20:32 augustus Exp $

inherit eutils fdo-mime

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
SRC_URI="http://dl.google.com/earth/GE4/GoogleEarthLinux.bin"

LICENSE="googleearth MIT X11 SGI-B-1.1 openssl as-is ZLIB"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="mirror strip"
QA_EXECSTACK_x86="opt/googleearth/libcrypto.so.0.9.8"
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
		x11-drivers/nvidia-drivers
		x11-drivers/nvidia-legacy-drivers
		>=x11-drivers/ati-drivers-8.8.25-r1 ) )
	media-fonts/ttf-bitstream-vera"

S=${WORKDIR}

src_unpack() {
	unpack_makeself
	# make the postinst scripts behave
	sed -i -e 's:$SETUP_INSTALLPATH/::' -e "s: --user: --system:" \
		-e 's:$SETUP_INSTALLPATH:1:' postinstall.sh
	sed -i -e "s:/usr:${D}/usr:g" -e "s:^detectDE$::" \
		-e 's:-x $x/update-mime:-d nonexis:' \
		-e 's:-x $x/update-desktop:-d nonexis:' linux/xdg/xdg-m{ime,enu}
}

src_install() {
	make_wrapper ${PN} ./${PN} /opt/${PN} . || die "make_wrapper failed"

	unset XDG_DATA_DIRS
	dodir /usr/share/{appl{ications,nk},gnome/apps,mime/packages}
	./postinstall.sh
	doicon ${PN}-icon.png

	dodoc README.linux

	cd bin
	tar xf ${WORKDIR}/${PN}-linux-x86.tar
	exeinto /opt/${PN}
	doexe *

	cd ${D}/opt/${PN}
	tar xf ${WORKDIR}/${PN}-data.tar

	# make sure we install with correct permissions
	fowners -R root:root /opt/${PN}
	fperms -R a-x,a+X /opt/googleearth/{xml,res{,ources}}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
