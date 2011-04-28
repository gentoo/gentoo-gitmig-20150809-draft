# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium-bin/chromium-bin-9.0.597.84.ebuild,v 1.3 2011/04/28 16:27:20 ssuominen Exp $

EAPI="2"
inherit eutils multilib portability

DESCRIPTION="Open-source version of Google Chrome web browser (binary version)"
HOMEPAGE="http://code.google.com/chromium/"
SRC_URI="x86? ( mirror://gentoo/${PN}-x86-${PV}.tar.bz2 )
	amd64? ( mirror://gentoo/${PN}-amd64-${PV}.tar.bz2 )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="app-arch/bzip2
	dev-libs/dbus-glib
	dev-libs/expat
	dev-libs/glib
	=dev-libs/icu-4.6*
	>=dev-libs/libevent-1.4.13
	>=dev-libs/nspr-4.7
	>=dev-libs/nss-3.12.3
	>=gnome-base/gconf-2.24.0
	>=gnome-base/gnome-keyring-2.28.2
	>=media-libs/alsa-lib-1.0.19
	media-libs/fontconfig
	media-libs/freetype
	=media-libs/libpng-1.4*
	media-libs/libvpx
	>=media-video/ffmpeg-0.6_p25767[threads]
	>=net-print/cups-1.4.4
	sys-apps/dbus
	>=sys-libs/glibc-2.11.2
	sys-libs/zlib
	x11-apps/xmessage
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-libs/pango
	x11-misc/xdg-utils
	virtual/jpeg
	virtual/ttf-fonts
	|| (
		x11-themes/gnome-icon-theme
		x11-themes/oxygen-molecule
		x11-themes/tango-icon-theme
	)"

pkg_setup() {
	CHROMIUM_HOME="/opt/chromium.org"

	# Prevent user problems like bug #299777.
	if ! grep -q /dev/shm <<< $(get_mounts); then
		ewarn "You don't have tmpfs mounted at /dev/shm."
		ewarn "${PN} may fail to start in that configuration."
		ewarn "Please uncomment the /dev/shm entry in /etc/fstab,"
		ewarn "and run 'mount /dev/shm'."
	fi
	if [ `stat -c %a /dev/shm` -ne 1777 ]; then
		ewarn "/dev/shm does not have correct permissions."
		ewarn "${PN} may fail to start in that configuration."
		ewarn "Please run 'chmod 1777 /dev/shm'."
	fi
}

src_install() {
	dodir "${CHROMIUM_HOME}" || die
	insinto "${CHROMIUM_HOME}"
	cp -R usr/$(get_libdir)/chromium-browser/* "${D}/${CHROMIUM_HOME}" || die

	sed -e 's/chromium-chromium.desktop/chromium-bin-chromium-bin.desktop/g' \
		-i "${D}/${CHROMIUM_HOME}/chromium-launcher.sh" || die
	dosym "${CHROMIUM_HOME}/chromium-launcher.sh" /usr/bin/chromium-bin || die

	dosym /usr/$(get_libdir)/libavcodec.so.52 "${CHROMIUM_HOME}" || die
	dosym /usr/$(get_libdir)/libavformat.so.52 "${CHROMIUM_HOME}" || die
	dosym /usr/$(get_libdir)/libavutil.so.50 "${CHROMIUM_HOME}" || die

	newicon "${FILESDIR}"/chromium.png ${PN}.png
	make_desktop_entry chromium-bin "Chromium (bin)" ${PN} "Network;WebBrowser"
	sed -e "/^Exec/s/$/ %U/" -i "${D}"/usr/share/applications/*.desktop \
		|| die "desktop file sed failed"
}
