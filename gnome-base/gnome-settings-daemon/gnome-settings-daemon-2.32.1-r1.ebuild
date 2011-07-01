# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-settings-daemon/gnome-settings-daemon-2.32.1-r1.ebuild,v 1.3 2011/07/01 21:11:27 hwoarang Exp $

EAPI="3"
GCONF_DEBUG="yes"

inherit autotools eutils gnome2

DESCRIPTION="Gnome Settings Daemon"
HOMEPAGE="http://www.gnome.org"
SRC_URI="${SRC_URI} http://dev.gentoo.org/~pacho/gnome/gnome-settings-daemon-2.32.1-gst-vol-control-support.patch"

# Old patches:
# 	mirror://gentoo/${PN}-2.30.0-gst-vol-control-support.patch" -> this causes bug #327609
# 	mirror://gentoo/${PN}-2.30.2-gst-vol-control-support.patch.bz2" -> this patch has worse problems like bug #339732

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug libnotify policykit pulseaudio smartcard"

# libgnomekbd-2.91 breaks API/ABI
RDEPEND=">=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.21.2:2
	>=gnome-base/gconf-2.6.1:2
	>=gnome-base/libgnomekbd-2.31.2
	<gnome-base/libgnomekbd-2.91.0
	>=gnome-base/gnome-desktop-2.29.92:2

	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXext
	x11-libs/libXxf86misc
	>=x11-libs/libxklavier-5.0
	media-libs/fontconfig

	libnotify? ( >=x11-libs/libnotify-0.4.3 )
	policykit? (
		>=sys-auth/polkit-0.91
		>=dev-libs/dbus-glib-0.71
		>=sys-apps/dbus-1.1.2 )
	pulseaudio? (
		>=media-sound/pulseaudio-0.9.15
		media-libs/libcanberra[gtk] )
	!pulseaudio? (
		>=media-libs/gstreamer-0.10.1.2:0.10
		>=media-libs/gst-plugins-base-0.10.1.2:0.10 )
	smartcard? ( >=dev-libs/nss-3.11.2 )"

DEPEND="${RDEPEND}
	!<gnome-base/gnome-control-center-2.22
	sys-devel/gettext
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.19
	x11-proto/inputproto
	x11-proto/xproto"

pkg_setup() {
	# README is empty
	DOCS="AUTHORS NEWS ChangeLog MAINTAINERS"
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable debug)
		$(use_with libnotify)
		$(use_enable policykit polkit)
		$(use_enable pulseaudio pulse)
		$(use_enable !pulseaudio gstreamer)
		$(use_enable smartcard smartcard-support)"

	if use pulseaudio; then
		elog "Building volume media keys using Pulseaudio"
	else
		elog "Building volume media keys using GStreamer"
	fi
}

src_prepare() {
	gnome2_src_prepare

	# libnotify-0.7.1 compatibility patches
	epatch "${FILESDIR}"/${PN}-2.32.1-libnotify-0.7.patch
	epatch "${FILESDIR}"/${PN}-2.32.1-libnotify-init.patch

	# Restore gstreamer volume control support, upstream bug #571145
	# Keep using old patch as it doesn't cause problems like bug #339732
#	epatch "${WORKDIR}/${PN}-2.30.2-gst-vol-control-support.patch"
#	echo "plugins/media-keys/cut-n-paste/gvc-gstreamer-acme-vol.c" >> po/POTFILES.in
	# We use now debian patch as looks to fix bug #327609
#	epatch "${DISTDIR}/${PN}-2.30.0-gst-vol-control-support.patch"
	epatch "${DISTDIR}/${PN}-2.32.1-gst-vol-control-support.patch"

	# More network filesystems not to monitor, upstream bug #606421
	epatch "${FILESDIR}/${PN}-2.32.1-netfs-monitor.patch"

	# xsettings: Export Xft.lcdfilter for OO.o's benefit, upstream bug #631924
	epatch "${FILESDIR}/${PN}-2.32.1-lcdfilter.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_install() {
	gnome2_src_install
	find "${ED}" -name "*.la" -delete
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! use pulseaudio; then
		elog "GStreamer volume control support is a feature powered by Gentoo GNOME Team"
		elog "PLEASE DO NOT report bugs upstream, report on https://bugs.gentoo.org instead"
	fi
}
