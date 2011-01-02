# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/totem/totem-2.32.0.ebuild,v 1.4 2011/01/02 16:57:20 maekke Exp $

EAPI="3"
GCONF_DEBUG="yes"
PYTHON_DEPEND="python? 2"
PYTHON_USE_WITH="threads"

inherit autotools eutils gnome2 multilib python

DESCRIPTION="Media player for GNOME"
HOMEPAGE="http://gnome.org/projects/totem/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc64 ~x86 ~x86-fbsd"

# FIXME: Enable for now python USE flag per bug #316409
# this change should only be noticed by people not following current
# current linux profiles default
IUSE="bluetooth debug doc galago iplayer lirc nautilus nsplugin +python tracker upnp +youtube" #zeroconf

# TODO:
# Cone (VLC) plugin needs someone with the right setup (remi ?)
# check gmyth requirement ? -> waiting for updates in tree
# vala ( dev-lang/vala ) requires 0.7.5
RDEPEND=">=dev-libs/glib-2.25.11:2
	>=x11-libs/gtk+-2.21.8:2
	>=gnome-base/gconf-2
	>=dev-libs/totem-pl-parser-2.30.2
	>=x11-themes/gnome-icon-theme-2.16
	x11-libs/cairo
	>=dev-libs/libxml2-2.6
	>=dev-libs/dbus-glib-0.82
	>=media-libs/gstreamer-0.10.30
	>=media-libs/gst-plugins-good-0.10
	>=media-libs/gst-plugins-base-0.10.30
	>=media-plugins/gst-plugins-gconf-0.10

	>=media-plugins/gst-plugins-taglib-0.10
	>=media-plugins/gst-plugins-gio-0.10
	>=media-plugins/gst-plugins-pango-0.10
	>=media-plugins/gst-plugins-x-0.10
	>=media-plugins/gst-plugins-meta-0.10-r2

	dev-libs/libunique
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXtst
	>=x11-libs/libXrandr-1.1.1
	>=x11-libs/libXxf86vm-1.0.1

	bluetooth? ( net-wireless/bluez )
	galago? ( >=dev-libs/libgalago-0.5.2 )
	iplayer? (
		dev-python/pygobject:2
		dev-python/pygtk:2
		dev-python/httplib2
		dev-python/feedparser
		dev-python/beautifulsoup )
	lirc? ( app-misc/lirc )
	nautilus? ( >=gnome-base/nautilus-2.10 )
	nsplugin? ( media-plugins/gst-plugins-soup )
	python? (
		>=dev-python/pygtk-2.12:2
		dev-python/pyxdg
		dev-python/gst-python
		dev-python/dbus-python
		dev-python/gconf-python )
	tracker? ( >=app-misc/tracker-0.8.1 )
	upnp? ( media-video/coherence )
	youtube? (
		>=dev-libs/libgdata-0.4
		net-libs/libsoup:2.4
		media-plugins/gst-plugins-soup )"
# FIXME: freezes totem
#	zeroconf? ( >=net-libs/libepc-0.3 )
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	>=dev-util/intltool-0.40
	>=dev-util/pkgconfig-0.20
	app-text/docbook-xml-dtd:4.5
	gnome-base/gnome-common
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.11 )"
# eautoreconf needs:
#	gnome-base/gnome-common
#	dev-util/gtk-doc-am

# docbook-xml-dtd is needed for user doc

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README TODO"
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-schemas-install
		--disable-static
		--disable-vala
		--with-dbus
		--with-smclient
		--enable-easy-codec-installation
		$(use_enable nsplugin browser-plugins)"

	# Plugin configuration
	G2CONF="${G2CONF}
		BROWSER_PLUGIN_DIR=/usr/$(get_libdir)/nsbrowser/plugins
		PLUGINDIR=/usr/$(get_libdir)/totem/plugins"

	local plugins="properties,thumbnail,screensaver,ontop,gromit,media-player-keys,skipto,brasero-disc-recorder,screenshot,chapters"
	use bluetooth && plugins="${plugins},bemused"
	use galago && plugins="${plugins},galago"
	use iplayer && plugins="${plugins},iplayer"
	use lirc && plugins="${plugins},lirc"
	use python && plugins="${plugins},opensubtitles,jamendo,pythonconsole,dbus-service"
	use tracker && plugins="${plugins},tracker"
	use upnp && plugins="${plugins},coherence_upnp"
	use youtube && plugins="${plugins},youtube"
	#use zeroconf && plugins="${plugins},publish"

	G2CONF="${G2CONF} --with-plugins=${plugins}"

	G2CONF="${G2CONF}
		$(use_enable debug)
		$(use_enable nautilus)
		$(use_enable python)"

	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# Fix broken smclient option passing
	epatch "${FILESDIR}/${PN}-2.32.0-smclient-target-detection.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_configure() {
	# FIXME: why does it need write access here, probably need to set up a fake
	# home in /var/tmp like other pkgs do

	addpredict "$(unset HOME; echo ~)/.gconf"
	addpredict "$(unset HOME; echo ~)/.gconfd"
	addpredict "$(unset HOME; echo ~)/.gnome2"

	gnome2_src_configure
}

src_install() {
	gnome2_src_install
	# Installed for plugins, but they're dlopen()-ed
	# firefox, totem as well as nautilus
	find "${ED}" -name "*.la" -delete || die "remove of la files failed"

	# Fix python script shebangs
	python_convert_shebangs 2 "${ED}"/usr/libexec/totem/totem-bugreport.py
}

pkg_postinst() {
	gnome2_pkg_postinst
	if use python; then
		python_need_rebuild
		python_mod_optimize /usr/$(get_libdir)/totem/plugins
	fi

	ewarn
	ewarn "If totem doesn't play some video format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta"
	ewarn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/totem/plugins
}
