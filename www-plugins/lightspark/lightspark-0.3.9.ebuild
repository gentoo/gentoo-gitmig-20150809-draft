# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/lightspark/lightspark-0.3.9.ebuild,v 1.1 2010/05/25 09:04:14 chithanh Exp $

EAPI=3
inherit cmake-utils nsplugins multilib

DESCRIPTION="High performance flash player"
HOMEPAGE="https://launchpad.net/lightspark/"
SRC_URI="https://launchpad.net/~sssup/+archive/sssup-ppa/+files/${P/-/_}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nsplugin"

RDEPEND="dev-libs/libpcre
	media-fonts/liberation-fonts
	media-video/ffmpeg
	media-libs/ftgl
	media-libs/glew
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

src_prepare() {
	# TODO: have to think of a less ugly solution
	epatch "${FILESDIR}"/${PN}-0.3.3-llvm-datatypes.patch

	# Adjust plugin permissions
	sed -i "s|FILES|PROGRAMS|" plugin-dir/CMakeLists.txt || die

	# Adjust font paths
	sed -i "s|truetype/ttf-liberation|liberation-fonts|" swf.cpp || die
}

src_configure() {
	local mycmakeargs="$(cmake-utils_use nsplugin COMPILE_PLUGIN)
		-DPLUGIN_DIRECTORY=/usr/$(get_libdir)/${PN}/plugins"

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use nsplugin && inst_plugin /usr/$(get_libdir)/${PN}/plugins/liblightsparkplugin.so
}
