# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/lightspark/lightspark-0.4.5.ebuild,v 1.2 2010/12/12 21:21:38 chithanh Exp $

EAPI=3
inherit cmake-utils nsplugins multilib

DESCRIPTION="High performance flash player"
HOMEPAGE="https://launchpad.net/lightspark/"
SRC_URI="http://launchpad.net/${PN}/trunk/${P}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nsplugin pulseaudio"

RDEPEND="dev-cpp/libxmlpp:2.6
	dev-libs/libpcre[cxx]
	media-fonts/liberation-fonts
	media-video/ffmpeg
	media-libs/fontconfig
	media-libs/ftgl
	>=media-libs/glew-1.5.3
	media-libs/libsdl
	pulseaudio? (
		media-sound/pulseaudio
	)
	net-misc/curl
	>=sys-devel/gcc-4.4
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

PATCHES=(
	"${FILESDIR}"/${PN}-0.4.4.3-cmakelists.patch
	"${FILESDIR}"/${PN}-0.4.5-allow-disabling-pulseaudio.patch
	"${FILESDIR}"/${PN}-0.4.5-llvm-2.8-gcc-4.5.patch
)

src_configure() {
	local audiobackends
	use pulseaudio && audiobackends=pulse

	local mycmakeargs=(
		$(cmake-utils_use nsplugin COMPILE_PLUGIN)
		-DAUDIO_BACKEND="${audiobackends}"
		-DPLUGIN_DIRECTORY=/usr/$(get_libdir)/${PN}/plugins
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	use nsplugin && inst_plugin /usr/$(get_libdir)/${PN}/plugins/liblightsparkplugin.so
}

pkg_postinst() {
	if use nsplugin && ! has_version www-plugins/gnash; then
		elog "Lightspark now supports gnash fallback for its browser plugin."
		elog "Install www-plugins/gnash to take advantage of it."
	fi
	if use nsplugin && has_version www-plugins/gnash[nsplugin]; then
		elog "Having two plugins installed for the same MIME type may confuse"
		elog "Mozilla based browsers. It is recommended to disable the nsplugin"
		elog "USE flag for either gnash or lightspark. For details, see"
		elog "https://bugzilla.mozilla.org/show_bug.cgi?id=581848"
	fi
}
