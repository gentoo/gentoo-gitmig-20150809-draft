# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-simulation/secondlife/secondlife-1.23_rc4-r1.ebuild,v 1.2 2009/08/22 19:12:16 ssuominen Exp $

inherit eutils multilib games versionator

SECONDLIFE_REVISION=123523
SECONDLIFE_MAJOR_VER=$(get_version_component_range 1-2)
SECONDLIFE_MINOR_VER=$(get_version_component_range 3)
SECONDLIFE_MINOR_VER=${SECONDLIFE_MINOR_VER/rc/}
MY_P="slviewer-src-viewer-rc-frozen-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}.${SECONDLIFE_REVISION}"

DESCRIPTION="The Second Life (an online, 3D virtual world) viewer"
HOMEPAGE="http://secondlife.com/"
SRC_URI="http://automated-builds-secondlife-com.s3.amazonaws.com/viewer-rc-frozen/${MY_P}.tar.gz http://automated-builds-secondlife-com.s3.amazonaws.com/viewer-rc-frozen/slviewer-artwork-viewer-rc-frozen-${SECONDLIFE_MAJOR_VER}.${SECONDLIFE_MINOR_VER}.${SECONDLIFE_REVISION}.zip"

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
	dev-libs/xmlrpc-epi
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
	=virtual/libstdc++-3*
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

	# Disable NDOF (joystick) that will not compile
	epatch "${FILESDIR}/${PN}-disable-ndof.patch"

	# Fix uninitialized GdkColor
	epatch "${FILESDIR}/${P}-fix-uninitialized-gdkcolor.patch"

	# Fix memset used with constant zero length parameter error
	epatch "${FILESDIR}/${P}-fix-memset-error.patch"

	# Fix printf format type error
	epatch "${FILESDIR}/${P}-fix-printf-format-error.patch"
}

src_compile() {
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
	#cp -dR bin secondlife *.sh "${D}"/usr/lib/${PN} || die
	#rm -r bin secondlife *.sh || die
	cp -dR * "${D}"/usr/lib/${PN} || die
	chmod o-x "${D}"/usr/lib/${PN}/bin/* "${D}"/usr/lib/${PN}/secondlife "${D}"/usr/lib/${PN}/*.sh || die
	chgrp games "${D}"/usr/lib/${PN}/bin/* "${D}"/usr/lib/${PN}/secondlife "${D}"/usr/lib/${PN}/*.sh || die

	games_make_wrapper secondlife "./secondlife --set VersionChannelName Gentoo" /usr/lib/${PN} /usr/lib/${PN}
	make_desktop_entry secondlife "Second Life" /usr/share/${PN}/secondlife_icon.png

	prepgamesdirs
}
