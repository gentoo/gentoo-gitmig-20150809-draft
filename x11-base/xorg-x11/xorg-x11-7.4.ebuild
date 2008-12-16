# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/xorg-x11/xorg-x11-7.4.ebuild,v 1.9 2008/12/16 20:51:12 ranger Exp $

inherit eutils

DESCRIPTION="An X11 implementation maintained by the X.Org Foundation (meta package)"
HOMEPAGE="http://xorg.freedesktop.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

# Collision protect will scream bloody murder if we install over old versions
RDEPEND="!<=x11-base/xorg-x11-6.9"

# Server
RDEPEND="${RDEPEND}
	>=x11-base/xorg-server-1.5.2"

# Applications
RDEPEND="${RDEPEND}
	>=x11-apps/appres-1.0.1
	>=x11-apps/bitmap-1.0.3
	>=x11-apps/iceauth-1.0.2
	>=x11-apps/luit-1.0.3
	>=x11-apps/mkfontdir-1.0.4
	>=x11-apps/mkfontscale-1.0.5
	>=x11-apps/sessreg-1.0.4
	>=x11-apps/setxkbmap-1.0.4
	>=x11-apps/smproxy-1.0.2
	>=x11-apps/x11perf-1.5
	>=x11-apps/xauth-1.0.3
	>=x11-apps/xbacklight-1.1
	>=x11-apps/xcmsdb-1.0.1
	>=x11-apps/xcursorgen-1.0.2
	>=x11-apps/xdpyinfo-1.0.3
	>=x11-apps/xdriinfo-1.0.2
	>=x11-apps/xev-1.0.3
	>=x11-apps/xf86dga-1.0.2
	>=x11-apps/xgamma-1.0.2
	>=x11-apps/xhost-1.0.2
	>=x11-misc/xinput-1.3.0
	>=x11-apps/xkbcomp-1.0.5
	>=x11-apps/xkbevd-1.0.2
	>=x11-apps/xkbutils-1.0.1
	>=x11-apps/xkill-1.0.1
	>=x11-apps/xlsatoms-1.0.1
	>=x11-apps/xlsclients-1.0.1
	>=x11-apps/xmodmap-1.0.3
	>=x11-apps/xpr-1.0.2
	>=x11-apps/xprop-1.0.4
	>=x11-apps/xrandr-1.2.3
	>=x11-apps/xrdb-1.0.5
	>=x11-apps/xrefresh-1.0.2
	>=x11-apps/xset-1.0.4
	>=x11-apps/xsetmode-1.0.0
	>=x11-apps/xsetroot-1.0.2
	>=x11-apps/xvinfo-1.0.2
	>=x11-apps/xwd-1.0.2
	>=x11-apps/xwininfo-1.0.4
	>=x11-apps/xwud-1.0.1
	"

# Libraries
# AppleWM, WindowsWM, and dmx removed from upstream list
RDEPEND="${RDEPEND}
	>=x11-libs/libFS-1.0.1
	>=x11-libs/libICE-1.0.4
	>=x11-libs/libSM-1.1.0
	>=x11-libs/libX11-1.1.5
	>=x11-libs/libXScrnSaver-1.1.3
	>=x11-libs/libXau-1.0.4
	>=x11-libs/libXaw-1.0.4
	>=x11-libs/libXcomposite-0.4.0
	>=x11-libs/libXcursor-1.1.9
	>=x11-libs/libXdamage-1.1.1
	>=x11-libs/libXdmcp-1.0.2
	>=x11-libs/libXext-1.0.4
	>=x11-libs/libXfixes-4.0.3
	>=x11-libs/libXfont-1.3.3
	>=x11-libs/libXfontcache-1.0.4
	>=x11-libs/libXft-2.1.13
	>=x11-libs/libXi-1.1.3
	>=x11-libs/libXinerama-1.0.3
	>=x11-libs/libXmu-1.0.4
	>=x11-libs/libXpm-3.5.7
	>=x11-libs/libXrandr-1.2.3
	>=x11-libs/libXrender-0.9.4
	>=x11-libs/libXres-1.0.3
	>=x11-libs/libXt-1.0.5
	>=x11-libs/libXtst-1.0.3
	>=x11-libs/libXv-1.0.4
	>=x11-libs/libXvMC-1.0.4
	>=x11-libs/libXxf86dga-1.0.2
	>=x11-libs/libXxf86misc-1.0.1
	>=x11-libs/libXxf86vm-1.0.2
	>=x11-libs/libfontenc-1.0.4
	>=x11-libs/libpciaccess-0.10.3
	>=x11-libs/libxkbfile-1.0.5
	>=x11-libs/xtrans-1.2.2
	"

# Protocol headers
# AppleWM, WindowsWM, and dmx removed from upstream list
DEPEND="${DEPEND}
	>=x11-proto/bigreqsproto-1.0.2
	>=x11-proto/compositeproto-0.4
	>=x11-proto/damageproto-1.1.0
	>=x11-proto/evieext-1.0.2
	>=x11-proto/fixesproto-4.0
	>=x11-proto/fontcacheproto-0.1.2
	>=x11-proto/fontsproto-2.0.2
	>=x11-proto/glproto-1.4.9
	>=x11-proto/inputproto-1.4.4
	>=x11-proto/kbproto-1.0.3
	>=x11-proto/randrproto-1.2.1
	>=x11-proto/recordproto-1.13.2
	>=x11-proto/renderproto-0.9.3
	>=x11-proto/resourceproto-1.0.2
	>=x11-proto/scrnsaverproto-1.1.0
	>=x11-proto/trapproto-3.4.3
	>=x11-proto/videoproto-2.2.2
	>=x11-proto/xcmiscproto-1.1.2
	>=x11-proto/xextproto-7.0.3
	>=x11-proto/xf86bigfontproto-1.1.2
	>=x11-proto/xf86dgaproto-2.0.3
	>=x11-proto/xf86driproto-2.0.4
	>=x11-proto/xf86miscproto-0.9.2
	>=x11-proto/xf86vidmodeproto-2.2.2
	>=x11-proto/xineramaproto-1.1.2
	>=x11-proto/xproto-7.0.13
	"

# Data
RDEPEND="${RDEPEND}
	>=x11-misc/xbitmaps-1.0.1
	>=x11-themes/xcursor-themes-1.0.1
	"

# Utilities
RDEPEND="${RDEPEND}
	>=x11-misc/makedepend-1.0.1
	>=x11-misc/util-macros-1.1.6-r1
	"

# Fonts
RDEPEND="${RDEPEND}
	>=media-fonts/font-adobe-100dpi-1.0.0
	>=media-fonts/font-adobe-75dpi-1.0.0
	>=media-fonts/font-adobe-utopia-100dpi-1.0.1
	>=media-fonts/font-adobe-utopia-75dpi-1.0.1
	>=media-fonts/font-adobe-utopia-type1-1.0.1
	>=media-fonts/font-alias-1.0.1
	>=media-fonts/font-arabic-misc-1.0.0
	>=media-fonts/font-bh-100dpi-1.0.0
	>=media-fonts/font-bh-75dpi-1.0.0
	>=media-fonts/font-bh-lucidatypewriter-100dpi-1.0.0
	>=media-fonts/font-bh-lucidatypewriter-75dpi-1.0.0
	>=media-fonts/font-bh-ttf-1.0.0
	>=media-fonts/font-bh-type1-1.0.0
	>=media-fonts/font-bitstream-100dpi-1.0.0
	>=media-fonts/font-bitstream-75dpi-1.0.0
	>=media-fonts/font-bitstream-speedo-1.0.0
	>=media-fonts/font-bitstream-type1-1.0.0
	>=media-fonts/font-cronyx-cyrillic-1.0.0
	>=media-fonts/font-cursor-misc-1.0.0
	>=media-fonts/font-daewoo-misc-1.0.0
	>=media-fonts/font-dec-misc-1.0.0
	>=media-fonts/font-ibm-type1-1.0.0
	>=media-fonts/font-isas-misc-1.0.0
	>=media-fonts/font-jis-misc-1.0.0
	>=media-fonts/font-micro-misc-1.0.0
	>=media-fonts/font-misc-cyrillic-1.0.0
	>=media-fonts/font-misc-ethiopic-1.0.0
	>=media-fonts/font-misc-meltho-1.0.0
	>=media-fonts/font-misc-misc-1.0.0
	>=media-fonts/font-mutt-misc-1.0.0
	>=media-fonts/font-schumacher-misc-1.0.0
	>=media-fonts/font-screen-cyrillic-1.0.1
	>=media-fonts/font-sony-misc-1.0.0
	>=media-fonts/font-sun-misc-1.0.0
	>=media-fonts/font-util-1.0.1
	>=media-fonts/font-winitzki-cyrillic-1.0.0
	>=media-fonts/font-xfree86-type1-1.0.1

	>=media-fonts/font-alias-1.0.1
	>=media-fonts/font-util-1.0.1
	>=media-fonts/encodings-1.0.2
	"

# Documentation
RDEPEND="${RDEPEND}
	>=app-doc/xorg-sgml-doctools-1.2
	>=app-doc/xorg-docs-1.4
	"

DEPEND="${RDEPEND}"

src_install() {
	# Make /usr/X11R6 a symlink to ../usr.
	dodir /usr
	dosym ../usr /usr/X11R6
}

pkg_preinst() {
	# Check for /usr/X11R6 -> /usr symlink
	if [[ -e "${ROOT}usr/X11R6" ]] &&
		[[ $(readlink "${ROOT}usr/X11R6") != "../usr" ]]; then
			eerror "${ROOT}usr/X11R6 isn't a symlink to ../usr. Please delete it."
			ewarn "First, save a list of all the packages installing there:"
			ewarn "		equery belongs ${ROOT}usr/X11R6 > usr-x11r6-packages"
			ewarn "This requires gentoolkit to be installed."
			die "${ROOT}usr/X11R6 is not a symlink to ../usr."
	fi

	# Filter out ModulePath line since it often holds a now-invalid path
	# Bug #112924
	# For RC3 - filter out RgbPath line since it also seems to break things
	XORGCONF="/etc/X11/xorg.conf"
	if [[ -e ${ROOT}${XORGCONF} ]]; then
		mkdir -p "${D}/etc/X11"
		sed "/ModulePath/d" "${ROOT}${XORGCONF}" > "${D}${XORGCONF}"
		sed -i "/RgbPath/d" "${D}${XORGCONF}"
	fi
}

pkg_postinst() {
	elog
	elog "Please note that the xcursors are in ${ROOT}usr/share/cursors/${PN}."
	elog "Any custom cursor sets should be placed in that directory."
	elog
	elog "If you wish to set system-wide default cursors, please create"
	elog "${ROOT}usr/local/share/cursors/${PN}/default/index.theme"
	elog "with content: \"Inherits=theme_name\" so that future"
	elog "emerges will not overwrite those settings."
	elog
	elog "Listening on TCP is disabled by default with startx."
	elog "To enable it, edit ${ROOT}usr/bin/startx."
	elog

	elog "If you encounter any non-configuration issues, please file a bug at"
	elog "http://bugs.gentoo.org/enter_bug.cgi?product=Gentoo%20Linux"
	elog "and attach ${ROOT}etc/X11/xorg.conf, ${ROOT}var/log/Xorg.0.log and emerge info"
	elog
	elog "You can choose which drivers are installed with the VIDEO_CARDS"
	elog "and INPUT_DEVICES settings. Set these like any other Portage"
	elog "variable in ${ROOT}etc/make.conf or on the command line."
	elog

	# (#76985)
	elog "Visit http://www.gentoo.org/doc/en/index.xml?catid=desktop"
	elog "for more information on configuring X."
	elog

	# Try to get people to read this, pending #11359
	ebeep 5
	epause 10
}
