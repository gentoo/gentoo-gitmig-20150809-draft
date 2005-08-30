# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-1.1.5.ebuild,v 1.1 2005/08/30 02:31:45 allanonjl Exp $

inherit gnome2 eutils

DESCRIPTION="Media player for GNOME"
HOMEPAGE="http://gnome.org/projects/totem/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome xine lirc mad mpeg ogg vorbis a52 flac theora dvd debug mozilla firefox win32codecs xv"

RDEPEND=">=dev-libs/glib-2.6.3
	>=x11-libs/gtk+-2.6
	>=gnome-base/gnome-vfs-2.9.92
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2.2
	>=gnome-base/libgnomeui-2.4
	>=x11-themes/gnome-icon-theme-2.10
	app-text/iso-codes
	gnome? ( >=gnome-base/nautilus-2.10 )
	lirc? ( app-misc/lirc )
	xine? ( >=media-libs/xine-lib-1
		>=gnome-base/gconf-2 )
	!xine? ( >=media-libs/gstreamer-0.8.10
		>=media-libs/gst-plugins-0.8.10
		>=media-plugins/gst-plugins-gnomevfs-0.8.10
		xv? ( >=media-plugins/gst-plugins-xvideo-0.8.10 )
		>=media-plugins/gst-plugins-pango-0.8.10
		>=media-plugins/gst-plugins-ffmpeg-0.8.6
		mad? ( >=media-plugins/gst-plugins-mad-0.8.10 )
		mpeg? ( >=media-plugins/gst-plugins-mpeg2dec-0.8.10 )
		ogg? ( >=media-plugins/gst-plugins-ogg-0.8.10 )
		vorbis? ( >=media-plugins/gst-plugins-ogg-0.8.10
			>=media-plugins/gst-plugins-vorbis-0.8.10 )
		a52? ( >=media-plugins/gst-plugins-a52dec-0.8.10 )
		flac? ( >=media-plugins/gst-plugins-flac-0.8.10 )
		theora? ( >=media-plugins/gst-plugins-ogg-0.8.10
		        >=media-plugins/gst-plugins-theora-0.8.10 )
		mad? ( >=media-plugins/gst-plugins-mad-0.8.10 )
		dvd? ( >=media-plugins/gst-plugins-a52dec-0.8.10
			>=media-plugins/gst-plugins-dvdread-0.8.10
			>=media-plugins/gst-plugins-mpeg2dec-0.8.10 )
		win32codecs? ( >=media-plugins/gst-plugins-pitfdll-0.8.1 )
		)
	mozilla? ( >=www-client/mozilla-1.7.3 )
	firefox? ( >=www-client/mozilla-firefox-1.0.2-r1 )

	!gnome-extra/nautilus-media"

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

pkg_setup() {
	# gstreamer is default backend
	use xine || G2CONF="${G2CONF} --enable-gstreamer"

	G2CONF="${G2CONF} \
		$(use_enable lirc) \
		$(use_enable debug) \
		$(use_enable gnome nautilus) \
		--disable-gtk"

	if use firefox; then
		G2CONF="${G2CONF} \
		--enable-mozilla \
		--with-mozilla=firefox"
	elif use mozilla and !use firefox; then
		G2CONF="${G2CONF} \
		--enable-mozilla \
		--with-mozilla=mozilla"
	else
		G2CONF="${G2CONF}
		--disable-mozilla"
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}

	gnome2_omf_fix 	help/C/Makefile.in \
					help/de/Makefile.in \
					help/es/Makefile.in \
					help/ru/Makefile.in

	# fix the IDL path ( AllanonJL )
	epatch ${FILESDIR}/${P}-idl.patch
	# fix nsIDOMWindow.h include ( AllanonJL )
	epatch ${FILESDIR}/${P}-nsi.patch

	einfo "Regenerating autotools files..."
	export WANT_AUTOMAKE=1.9.5
	export WANT_AUTOCONF=2.5

	automake; aclocal -I .; libtoolize --copy --force; autoconf
}

pkg_postinst() {

	gnome2_pkg_postinst

	einfo "Note that the default totem backend has switched to gstreamer."
	einfo "DVD menus will only work with the xine backend."

}

USE_DESTDIR="1"
