# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/chromium-bin/chromium-bin-5.0.375.125.ebuild,v 1.1 2010/08/17 04:15:30 phajdan.jr Exp $

EAPI="2"
inherit eutils multilib

DESCRIPTION="Open-source version of Google Chrome web browser (binary version)"
HOMEPAGE="http://code.google.com/chromium/"
SRC_URI="x86? ( mirror://gentoo/${PN}-x86-${PV}.tar.bz2 )
	amd64? ( mirror://gentoo/${PN}-amd64-${PV}.tar.bz2 )"
LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+plugins-symlink"

DEPEND=""
RDEPEND="app-arch/bzip2
	dev-libs/dbus-glib
	dev-libs/expat
	dev-libs/glib
	>=dev-libs/libevent-1.4.13
	dev-libs/libxml2
	dev-libs/libxslt
	>=dev-libs/nspr-4.7
	>=dev-libs/nss-3.12.3
	>=gnome-base/gconf-2.24.0
	>=media-libs/alsa-lib-1.0.19
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg:0
	=media-libs/libpng-1.2*
	media-video/ffmpeg[threads]
	sys-apps/dbus
	sys-libs/zlib
	x11-apps/xmessage
	x11-libs/cairo
	>=x11-libs/gtk+-2.14.7
	x11-libs/libXScrnSaver
	x11-libs/pango
	x11-misc/xdg-utils
	virtual/ttf-fonts
	|| (
		x11-themes/gnome-icon-theme
		x11-themes/oxygen-molecule
		x11-themes/tango-icon-theme
		x11-themes/xfce4-icon-theme
	)"

get_chromium_home() {
	echo "/opt/chromium.org"
}

src_install() {
	dodir "$(get_chromium_home)" || die
	insinto "$(get_chromium_home)"
	cp -R usr/$(get_libdir)/chromium-browser/* "${D}/$(get_chromium_home)" || die

	# Plugins symlink, optional wrt bug #301911
	if use plugins-symlink; then
		dosym /usr/$(get_libdir)/nsbrowser/plugins "$(get_chromium_home)/plugins"
	fi

	make_wrapper chromium-bin ./chrome "$(get_chromium_home)"
	newicon "${FILESDIR}"/chromium.png ${PN}.png
	make_desktop_entry chromium-bin "Chromium (bin)" ${PN} "Network;WebBrowser"
	sed -e "/^Exec/s/$/ %U/" -i "${D}"/usr/share/applications/*.desktop \
		|| die "desktop file sed failed"
}
