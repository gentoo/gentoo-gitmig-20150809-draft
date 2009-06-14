# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/secondlife/secondlife-1.23_rc4.ebuild,v 1.1 2009/06/14 19:13:25 lavajoe Exp $

inherit eutils multilib games versionator

SECONDLIFE_REVISION=123523
SECONDLIFE_MAJOR_VER=$(get_version_component_range 1-2)
SECONDLIFE_MINOR_VER=$(get_version_component_range 3)
SECONDLIFE_MINOR_VER=${SECONDLIFE_MINOR_VER/rc/}
MY_P="slviewer-src-viewer-rc-frozen-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}.${SECONDLIFE_REVISION}"

DESCRIPTION="The Second Life (an online, 3D virtual world) viewer"
HOMEPAGE="http://secondlife.com/"
SRC_URI="http://automated-builds-secondlife-com.s3.amazonaws.com/viewer-rc-frozen/${MY_P}.tar.gz http://automated-builds-secondlife-com.s3.amazonaws.com/viewer-rc-frozen/slviewer-artwork-viewer-rc-frozen-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}.${SECONDLIFE_REVISION}.zip http://automated-builds-secondlife-com.s3.amazonaws.com/viewer-rc-frozen/slviewer-linux-libs-viewer-rc-frozen-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}.${SECONDLIFE_REVISION}.tar.gz mirror://sourceforge/xmlrpc-epi/xmlrpc-epi-0.54.tar.gz"

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

	# On 64-bit systems, we need to uncomment LL_BAD_OPENAL_DRIVER=x
	# and comment out the amd64 streaming disable to fix streaming audio.
	use amd64 && epatch "${FILESDIR}/${P}-amd64-audio-streaming-fix.patch"

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
