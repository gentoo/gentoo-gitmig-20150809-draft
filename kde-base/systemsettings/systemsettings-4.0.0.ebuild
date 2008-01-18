# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/systemsettings/systemsettings-4.0.0.ebuild,v 1.1 2008/01/18 02:06:35 ingmar Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="System settings utility"
IUSE="debug htmlhandbook ieee1394 opengl ssl +usb xinerama"
KEYWORDS="~amd64 ~x86"

COMMONDEPEND="
	>=app-misc/strigi-0.5.7
	>=dev-libs/glib-2
	media-libs/fontconfig
	>=media-libs/freetype-2
	>=x11-libs/libxklavier-3.2
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXft
	>=x11-libs/libXrandr-1.2.1
	x11-libs/libXtst
	ieee1394? ( sys-libs/libraw1394 )
	opengl? ( virtual/opengl
		virtual/glu )
	ssl? ( dev-libs/openssl )
	usb? ( >=dev-libs/libusb-0.1.10a )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${COMMONDEPEND}
	x11-proto/xextproto
	x11-proto/kbproto
	xinerama? ( x11-proto/xineramaproto )"
RDEPEND="${COMMONDEPEND}"

KMEXTRA="kcontrol/"

KMEXTRACTONLY="
	krunner/org.kde.krunner.App.xml
	krunner/org.kde.screensaver.xml
	kwin/
	libs/
	plasma/"

# FIXME: is have_openglxvisual found without screensaver
src_compile() {
	# Old keyboard-detection code is unmaintained,
	# so we force the new stuff, using libxklavier.
	mycmakeargs="${mycmakeargs}
		-DUSE_XKLAVIER=ON -DWITH_LibXKlavier=ON
		-DWITH_GLIB2=ON -DWITH_GObject=ON
		$(cmake-utils_usr_with ieee1394 RAW1394)
		$(cmake-utils_use_with opengl OpenGL)
		$(cmake-utils_use_with ssl OpenSSL)
		$(cmake-utils_use_with usb USB)
		$(cmake-utils_use_with xinerama X11_Xinerama)"
	kde4-meta_src_compile
}
