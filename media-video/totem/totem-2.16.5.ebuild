# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-2.16.5.ebuild,v 1.11 2007/08/25 14:19:04 vapier Exp $

inherit autotools eutils multilib gnome2

DESCRIPTION="Media player for GNOME"
HOMEPAGE="http://gnome.org/projects/totem/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sh sparc x86 ~x86-fbsd"

# pitdfdll has not come out with a 0.10 release, should be soon though -AJL
# IUSE="win32codecs"

IUSE="a52 dbus dvd ffmpeg firefox flac gnome hal lirc mad mpeg nsplugin nvtv ogg theora vorbis xine xv"

RDEPEND=">=dev-libs/glib-2.8.0
	>=x11-libs/gtk+-2.6
	>=gnome-base/gnome-vfs-2.10
	>=gnome-base/libgnomeui-2.4
	>=x11-themes/gnome-icon-theme-2.10
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.2
	app-text/iso-codes
	>=gnome-base/gconf-2
	x11-libs/libXtst
	x11-libs/libX11
	x11-libs/libXxf86vm
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-proto/xf86vidmodeproto
	dbus? ( >=dev-libs/dbus-glib-0.71 )
	hal? ( =sys-apps/hal-0.5* )
	gnome? ( >=gnome-base/nautilus-2.10 )
	lirc? ( app-misc/lirc )
	sparc? ( >=www-client/mozilla-firefox-1.5 )
	nsplugin?	(
					firefox? ( >=www-client/mozilla-firefox-1.5 )
					!ppc64? ( !sparc? ( !firefox? ( >=www-client/seamonkey-1.0 ) ) )
					>=sys-apps/dbus-0.35
					>=x11-misc/shared-mime-info-0.17
				)
	xine? ( >=media-libs/xine-lib-1.1.2 )
	!xine?	(
				>=media-libs/gstreamer-0.10.1
				>=media-libs/gst-plugins-base-0.10.7
				>=media-libs/gst-plugins-good-0.10
				>=media-plugins/gst-plugins-pango-0.10
				>=media-plugins/gst-plugins-gconf-0.10
				!sparc? ( ffmpeg? ( >=media-plugins/gst-plugins-ffmpeg-0.10 ) )
				>=media-plugins/gst-plugins-gnomevfs-0.10
				a52? ( >=media-plugins/gst-plugins-a52dec-0.10 )
				!sparc?	(
							dvd?
								(
									>=media-plugins/gst-plugins-a52dec-0.10
									>=media-plugins/gst-plugins-mpeg2dec-0.10
									>=media-libs/gst-plugins-ugly-0.10
									>=media-plugins/gst-plugins-dvdread-0.10
								)
						)
				flac? ( >=media-plugins/gst-plugins-flac-0.10 )
				mad? ( >=media-plugins/gst-plugins-mad-0.10 )
				!sparc? ( mpeg? ( >=media-plugins/gst-plugins-mpeg2dec-0.10 ) )
				ogg? ( >=media-plugins/gst-plugins-ogg-0.10 )
				theora?	(
							>=media-plugins/gst-plugins-ogg-0.10
							>=media-plugins/gst-plugins-theora-0.10
						)
				vorbis? (
							>=media-plugins/gst-plugins-ogg-0.10
							>=media-plugins/gst-plugins-vorbis-0.10
						)
				xv? ( >=media-plugins/gst-plugins-xvideo-0.10 )
			)
	nvtv? ( >=media-tv/nvtv-0.4.5 )"

# this belongs above xv? above.
# win32codecs? ( >=media-plugins/gst-plugins-pitfdll-0.10 )

DEPEND="${RDEPEND}
		app-text/scrollkeeper
		>=dev-util/intltool-0.35
		>=dev-util/pkgconfig-0.20"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
			--disable-vanity \
			--disable-gtk \
			$(use_with dbus) \
			$(use_with hal) \
			$(use_enable gnome nautilus) \
			$(use_enable lirc) \
			$(use_enable nvtv)"

	if use nsplugin ; then
		G2CONF="${G2CONF} --enable-browser-plugins"

		if use firefox || use sparc; then
			G2CONF="${G2CONF} --with-mozilla=firefox"
		else
			G2CONF="${G2CONF} --with-mozilla=seamonkey"
		fi
	else
		G2CONF="${G2CONF} --disable-browser-plugins"
	fi

	# gstreamer is default backend
	use xine || G2CONF="${G2CONF} --enable-gstreamer=yes"

	# Use global nsplugins dir
	G2CONF="${G2CONF} MOZILLA_PLUGINDIR=/usr/$(get_libdir)/nsbrowser"
}

src_unpack() {
	gnome2_src_unpack

	# Fix hardcoded plugindir
	sed -i -e \
		's|mozilla|nsbrowser|' \
		${S}/browser-plugin/Makefile.in \
		${S}/browser-plugin/idl/Makefile.in

	# fixes for ff compiles.
	if use nsplugin && ( use firefox || use sparc ); then
		epatch ${FILESDIR}/${PN}-1.5.91-mozilla-firefox-include-fix.patch

		# Patch borrowed from ubuntu (link xpcom)
		epatch ${FILESDIR}/01_build_mozilla_plugin_with_firefox_xpcom.patch
	elif use nsplugin ; then
		# Patch borrowed from ubuntu (link xpcom)
		epatch ${FILESDIR}/01_build_mozilla_plugin_with_seamonkey_xpcom.patch
	fi
}

src_compile() {
	#fixme: why does it need write access here, probably need to set up a fake
	#home in /var/tmp like other pkgs do
	addpredict "/root/.gconfd"
	addpredict "/root/.gconf"
	addpredict "/root/.gnome2"
	addpredict "/root/.gstreamer-0.10"

	gnome2_src_compile
}

pkg_postinst() {
	gnome2_pkg_postinst

	if ! use xine ; then
		elog "Note that the default totem backend has switched to gstreamer."
		elog "DVD menus will only work with the xine backend."
	fi
}
