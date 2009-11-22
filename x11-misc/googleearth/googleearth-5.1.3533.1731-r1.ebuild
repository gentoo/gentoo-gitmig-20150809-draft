# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/googleearth/googleearth-5.1.3533.1731-r1.ebuild,v 1.1 2009/11/22 10:50:29 caster Exp $

EAPI=2

inherit eutils fdo-mime versionator toolchain-funcs

DESCRIPTION="A 3D interface to the planet"
HOMEPAGE="http://earth.google.com/"
# no upstream versioning, version determined from help/about
# incorrect digest means upstream bumped and thus needs version bump
SRC_URI="http://dl.google.com/earth/client/current/GoogleEarthLinux.bin
			-> GoogleEarthLinux-${PV}.bin"

LICENSE="googleearth MIT X11 SGI-B-1.1 openssl as-is ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror strip"
IUSE=""

GCC_NEEDED="4.2"

RDEPEND=">=sys-devel/gcc-${GCC_NEEDED}[-nocxx]
	x86? (
		media-libs/fontconfig
		media-libs/freetype
		virtual/opengl
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXau
		x11-libs/libXdmcp
		sys-libs/zlib
		dev-libs/glib:2
	)
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-baselibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			<x11-drivers/ati-drivers-8.28.8
		)
	)
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
opt/googleearth/libmeasure.so
opt/googleearth/libgoogleearth_lib.so
opt/googleearth/libmoduleframework.so
"

QA_DT_HASH="opt/${PN}/.*"

pkg_setup() {
	GCC_VER="$(gcc-version)"
	if ! version_is_at_least ${GCC_NEEDED} ${GCC_VER}; then
		ewarn "${PN} needs libraries from gcc-${GCC_NEEDED} or higher to run"
		ewarn "Your active gcc version is only ${GCC_VER}"
		ewarn "Please consult the GCC upgrade guide to set a higher version:"
		ewarn "http://www.gentoo.org/doc/en/gcc-upgrading.xml"
	fi
}

src_unpack() {
	unpack_makeself
}

src_prepare() {
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
	# bug #262780
	epatch "${FILESDIR}/decimal-separator.patch"
	exeinto /opt/${PN}
	doexe *

	cd "${D}"/opt/${PN}
	tar xf "${WORKDIR}"/${PN}-data.tar

	fowners -R root:root /opt/${PN}
	fperms -R a-x,a+X /opt/googleearth/resources
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
