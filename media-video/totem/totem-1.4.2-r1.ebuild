# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-1.4.2-r1.ebuild,v 1.11 2006/10/20 17:59:00 agriffis Exp $

inherit autotools eutils multilib gnome2

DESCRIPTION="Media player for GNOME"
HOMEPAGE="http://gnome.org/projects/totem/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 sparc x86"

# pitdfall has not come out with a 0.10 release, should be soon though -AJL
#IUSE="a52 dbus dvd flac gnome lirc mad mpeg nsplugin nvtv ogg theora vorbis win32codecs xine xv"

IUSE="a52 dbus dvd firefox flac gnome lirc mad mpeg nsplugin nvtv ogg theora vorbis xine xv"

RDEPEND=">=dev-libs/glib-2.6.3
	>=x11-libs/gtk+-2.6
	>=gnome-base/gnome-vfs-2.9.92
	>=gnome-base/libgnomeui-2.4
	>=x11-themes/gnome-icon-theme-2.10
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.2
	app-text/iso-codes
	|| (
			(
				x11-libs/libXtst
				x11-libs/libX11
				x11-libs/libXxf86vm
				x11-libs/libXext
				x11-libs/libXrandr
				x11-libs/libXrender
			)
			virtual/x11
		)
	dbus? ( >=sys-apps/dbus-0.35 )
	gnome? ( >=gnome-base/nautilus-2.10 )
	lirc? ( app-misc/lirc )
	sparc? ( >=www-client/mozilla-firefox-1.5 )
	ppc64? ( >=www-client/seamonkey-1.0 )
	nsplugin? ( firefox? ( >=www-client/mozilla-firefox-1.5 )
				!sparc? ( !firefox? ( >=www-client/seamonkey-1.0 ) )
				>=sys-apps/dbus-0.35
			)
	xine? ( >=media-libs/xine-lib-1.0.1 )
	!xine?	(
				>=media-libs/gstreamer-0.10
				>=media-libs/gst-plugins-base-0.10.7
				>=media-libs/gst-plugins-good-0.10
				>=media-plugins/gst-plugins-pango-0.10
				>=media-plugins/gst-plugins-gconf-0.10
				!sparc? ( >=media-plugins/gst-plugins-ffmpeg-0.10 )
				>=media-plugins/gst-plugins-gnomevfs-0.10
				a52? ( >=media-plugins/gst-plugins-a52dec-0.10 )
				!sparc?	(
							dvd?
								(
									>=media-plugins/gst-plugins-a52dec-0.10
									>=media-plugins/gst-plugins-mpeg2dec-0.10
									>=media-libs/gst-plugins-ugly-0.10
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
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9"

DOCS="AUTHORS ChangeLog NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF} --disable-vanity \
			--disable-gtk \
			$(use_with dbus) \
			$(use_enable gnome nautilus) \
			$(use_enable lirc) \
			$(use_enable nvtv)"

	if use firefox || use sparc; then
		G2CONF="${G2CONF} \
				$(use_enable nsplugin mozilla) \
				$(use_with nsplugin mozilla firefox)"
	else
		G2CONF="${G2CONF} \
				$(use_enable nsplugin mozilla) \
				$(use_with nsplugin mozilla seamonkey)"
	fi

	# gstreamer is default backend
	use xine || G2CONF="${G2CONF} --enable-gstreamer=0.10"

	# Use global nsplugins dir
	G2CONF="${G2CONF} MOZILLA_PLUGINDIR=/usr/$(get_libdir)/nsbrowser"
}

src_unpack() {
	gnome2_src_unpack

	# Fix failure with autoconf 2.60, bug #138210
	epatch ${FILESDIR}/${PN}-1.4.0-autoconf.patch

	# fixes for seamonkey / ff compiles.
	epatch ${FILESDIR}/${PN}-1.4.1-nsIDOMWINDOW.patch
	epatch ${FILESDIR}/${PN}-1.4.2-nsIURI.patch

	eautoreconf
}

src_compile() {
	#fixme: why does it need write access here, probably need to set up a fake
	#home in /var/tmp like other pkgs do
	addpredict "/root/.gconfd"
	addpredict "/root/.gconf"
	addpredict "/root/.gnome2"
	gnome2_src_compile
}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Note that the default totem backend has switched to gstreamer."
	einfo "DVD menus will only work with the xine backend."

}
