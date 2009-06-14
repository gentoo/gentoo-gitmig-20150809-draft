# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/secondlife/secondlife-1.23_rc2.ebuild,v 1.1 2009/06/14 19:13:25 lavajoe Exp $

inherit eutils multilib games versionator

SECONDLIFE_REVISION=120719
SECONDLIFE_RELEASE_DIR=2009/05
SECONDLIFE_MAJOR_VER=$(get_version_component_range 1-2)
SECONDLIFE_MINOR_VER=$(get_version_component_range 3)
SECONDLIFE_MINOR_VER=${SECONDLIFE_MINOR_VER/rc/}
MY_P="slviewer-src-viewer-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}-r${SECONDLIFE_REVISION}"

DESCRIPTION="The Second Life (an online, 3D virtual world) viewer"
HOMEPAGE="http://secondlife.com/"
SRC_URI="http://secondlife.com/developers/opensource/downloads/${SECONDLIFE_RELEASE_DIR}/${MY_P}.tar.gz http://secondlife.com/developers/opensource/downloads/${SECONDLIFE_RELEASE_DIR}/slviewer-artwork-viewer-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}-r${SECONDLIFE_REVISION}.zip http://secondlife.com/developers/opensource/downloads/${SECONDLIFE_RELEASE_DIR}/slviewer-linux-libs-viewer-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}-r${SECONDLIFE_REVISION}.tar.gz mirror://sourceforge/xmlrpc-epi/xmlrpc-epi-0.54.tar.gz http://s3.amazonaws.com/viewer-source-downloads/install_pkgs/glh_linear-linux-20080613.tar.bz2"

LICENSE="GPL-2-with-Linden-Lab-FLOSS-exception Epinions"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-libs/glibc
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXext
	>=x11-libs/gtk+-2.0
	x11-libs/libXinerama
	dev-libs/libgcrypt
	dev-libs/libgpg-error
	dev-libs/openssl
	dev-libs/apr
	dev-libs/apr-util
	dev-libs/boost
	dev-libs/elfio
	dev-libs/expat
	dev-util/cmake
	media-libs/freetype
	media-libs/libogg
	media-libs/libsdl
	media-libs/libvorbis
	media-libs/gstreamer
	media-plugins/gst-plugins-meta
	media-libs/fmod
	media-libs/jpeg
	media-libs/openjpeg
	net-libs/gnutls
	net-misc/curl
	net-dns/c-ares
	sys-libs/zlib
	virtual/libstdc++
	virtual/glu
	virtual/opengl
	media-libs/openal
	media-libs/freealut"
RDEPEND="${DEPEND}"

S="${WORKDIR}/linden"

use amd64 && ARCH_LIBS_DIR="x86_64-linux"
use x86 && ARCH_LIBS_DIR="i686-linux"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix cmake include path (so it can find xmlrpc includes)
	epatch "${FILESDIR}/${PN}-fix-cmake-include-path.patch"

	# Disable NDOF (joystick) that will not compile
	epatch "${FILESDIR}/${PN}-disable-ndof.patch"

	# Fix uninitialized GdkColor
	epatch "${FILESDIR}/${P}-fix-uninitialized-gdkcolor.patch"

	# Fix memset used with constant zero length parameter error
	epatch "${FILESDIR}/${P}-fix-memset-error.patch"

	# Fix printf format type error
	epatch "${FILESDIR}/${P}-fix-printf-format-error.patch"

	# Move extra glh include file into place.
	# NOTE: This is hackish, since it had to be downloaded from the SL site
	#       separately as part of the batch used when *not* building the
	#       viewer standalone (this ebuild *does* build it standalone).
	mv ../indra/llwindow/glh indra/llwindow || die
	rm -r ../indra || die

	# Add local paths to the xmlrpc-epi cmake files.
	# NOTE: This lib is downloaded separately, since it is
	#       not available in Gentoo.
	sed -i -e"s:/usr/local/include:${S}/libraries/${ARCH_LIBS_DIR}/include /usr/local/include:" indra/cmake/FindXmlRpcEpi.cmake || die
	sed -i -e"s:/usr/lib:${S}/libraries/${ARCH_LIBS_DIR}/lib_release_client /usr/lib:" indra/cmake/FindXmlRpcEpi.cmake || die

	# Make 3rd party package area for xmlrpc-epi
	mkdir -p libraries/${ARCH_LIBS_DIR}/include || die
	mkdir libraries/${ARCH_LIBS_DIR}/lib_release_client || die
}

src_compile() {
	# First, build xmlrpc-epi
	cd "${WORKDIR}/xmlrpc-epi-"*

	econf
	emake || die

	# Copy relevant files from xmlrpc-epi to 3rd party package area
	rm src/.libs/libxmlrpc-epi.la || die
	cp src/libxmlrpc-epi.la src/.libs || die
	mkdir "${S}"/libraries/${ARCH_LIBS_DIR}/include/xmlrpc-epi || die
	cp -dR src/*.h "${S}"/libraries/${ARCH_LIBS_DIR}/include/xmlrpc-epi || die
	cp -dR src/.libs/libxmlrpc* "${S}"/libraries/${ARCH_LIBS_DIR}/lib_release_client || die

	# Now build the Second Life viewer
	cd "${S}/indra"

	./develop.py --standalone configure || die
	./develop.py --standalone build || die
}

src_install() {
	cd "${S}"/indra/viewer-*/newview/packaged || die

	dodoc README-*.txt licenses.txt || die
	rm README-*.txt licenses.txt || die

	insinto /usr/share/secondlife
	doins secondlife_icon.png || die
	rm secondlife_icon.png || die

	dodir /usr/lib/${PN} || die
	cp -dR "${S}"/libraries/${ARCH_LIBS_DIR}/lib_release_client/libxml* "${D}"/usr/lib/${PN} || die
	#cp -dR bin secondlife *.sh "${D}"/usr/lib/${PN} || die
	#rm -r bin secondlife *.sh || die
	cp -dR * "${D}"/usr/lib/${PN} || die
	chmod o-x "${D}"/usr/lib/${PN}/bin/* "${D}"/usr/lib/${PN}/secondlife "${D}"/usr/lib/${PN}/*.sh || die
	chgrp games "${D}"/usr/lib/${PN}/bin/* "${D}"/usr/lib/${PN}/secondlife "${D}"/usr/lib/${PN}/*.sh || die

	games_make_wrapper secondlife "./secondlife --set VersionChannelName Gentoo" /usr/lib/${PN} /usr/lib/${PN}
	make_desktop_entry secondlife "Second Life" /usr/share/${PN}/secondlife_icon.png

	prepgamesdirs
}
