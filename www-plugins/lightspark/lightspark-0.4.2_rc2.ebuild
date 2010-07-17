# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/lightspark/lightspark-0.4.2_rc2.ebuild,v 1.3 2010/07/17 10:01:17 chithanh Exp $

EAPI=3
inherit cmake-utils nsplugins multilib

DESCRIPTION="High performance flash player"
HOMEPAGE="https://launchpad.net/lightspark/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PN}-0.4.0/+download/${P/_/}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nsplugin pulseaudio"

RDEPEND="dev-libs/libpcre[cxx]
	media-fonts/liberation-fonts
	media-video/ffmpeg
	media-libs/ftgl
	>=media-libs/glew-1.5.3
	media-libs/libsdl
	net-misc/curl
	>=sys-devel/llvm-2.7
	virtual/opengl
	nsplugin? (
		dev-libs/nspr
		net-libs/xulrunner
		x11-libs/gtk+:2
		x11-libs/gtkglext
	)
	x11-libs/libX11"
DEPEND="${RDEPEND}
	dev-lang/nasm
	dev-util/pkgconfig"

S=${WORKDIR}/${P/_rc*/}

src_prepare() {
	# Fix gcc complaint about undefined debug variable
	epatch "${FILESDIR}"/${PN}-0.4.2-ndebug.patch

	# Adjust plugin permissions
	sed -i "s|FILES|PROGRAMS|" plugin-dir/CMakeLists.txt || die

	# Adjust font paths
	sed -i "s|truetype/ttf-liberation|liberation-fonts|" swf.cpp || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use nsplugin COMPILE_PLUGIN)
		$(cmake-utils_use pulseaudio ENABLE_SOUND)
		-DPLUGIN_DIRECTORY=/usr/$(get_libdir)/${PN}/plugins
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use nsplugin && inst_plugin /usr/$(get_libdir)/${PN}/plugins/liblightsparkplugin.so
}
