# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.12.1.ebuild,v 1.1 2009/04/28 15:38:31 dang Exp $

EAPI="2"

inherit eutils gnome2 python multilib virtualx

DESCRIPTION="Music management and playback software for GNOME"
HOMEPAGE="http://www.rhythmbox.org/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+brasero cdr daap doc hal ipod gnome-keyring libnotify lirc musicbrainz mtp nsplugin python test"

# FIXME: double check what to do with fm-radio plugin

SLOT="0"

RDEPEND=">=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.14
	>=gnome-base/libglade-2
	>=dev-libs/totem-pl-parser-2.22.0
	cdr? (
		brasero? ( >=app-cdr/brasero-0.9.1 )
		!brasero? ( >=gnome-extra/nautilus-cd-burner-2.21.6 ) )
	>=x11-libs/libsexy-0.1.5
	>=gnome-extra/gnome-media-2.14.0
	gnome-keyring? ( >=gnome-base/gnome-keyring-0.4.9 )
	musicbrainz? ( media-libs/musicbrainz:3 )
	>=net-libs/libsoup-2.4:2.4
	lirc? ( app-misc/lirc )
	hal? (
		ipod? ( >=media-libs/libgpod-0.6 )
		mtp? ( >=media-libs/libmtp-0.3.0 )
		>=sys-apps/hal-0.5 )
	daap? ( >=net-dns/avahi-0.6 )
	>=dev-libs/dbus-glib-0.71
	>=media-libs/gst-plugins-base-0.10.14
	>=media-plugins/gst-plugins-gnomevfs-0.10
	|| (
		>=media-plugins/gst-plugins-cdparanoia-0.10
		>=media-plugins/gst-plugins-cdio-0.10 )
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	>=media-plugins/gst-plugins-taglib-0.10.6
	libnotify? ( >=x11-libs/libnotify-0.3.2 )
	python? (
		>=dev-lang/python-2.4.2
		|| (
			>=dev-lang/python-2.5
			dev-python/celementtree )
		>=dev-python/pygtk-2.8
		>=dev-python/gnome-vfs-python-2.22.0
		>=dev-python/gconf-python-2.22.0
		>=dev-python/libgnome-python-2.22.0
		>=dev-python/gst-python-0.10.8 )
	nsplugin? ( || (
		net-libs/xulrunner
		www-client/seamonkey
		www-client/mozilla-firefox ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.40
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	doc? ( >=dev-util/gtk-doc-1.4 )
	test? ( dev-libs/check )"

DOCS="AUTHORS ChangeLog DOCUMENTERS INTERNALS \
	  MAINTAINERS MAINTAINERS.old NEWS README THANKS"

pkg_setup() {
	if ! use hal && use ipod; then
		ewarn "ipod support requires hal support.  Please"
		ewarn "re-emerge with USE=hal to enable ipod support"
	fi

	if ! use hal && use mtp; then
		ewarn "MTP support requires hal support.  Please"
		ewarn "re-emerge with USE=hal to enable MTP support"
	fi

	if ! use cdr ; then
		ewarn "You have cdr USE flag disabled."
		ewarn "You will not be able to play audio CDs."
	fi

	if use brasero; then
		G2CONF="${G2CONF} $(use_with cdr libbrasero-media) --without-libnautilus-burn"
	else
		G2CONF="${G2CONF} $(use_with cdr libnautilus-burn) --without-libbrasero-media"
	fi

	G2CONF="${G2CONF}
		MOZILLA_PLUGINDIR=/usr/$(get_libdir)/nsbrowser/plugins
		$(use_with gnome-keyring)
		$(use_with ipod)
		$(use_enable libnotify)
		$(use_enable lirc)
		$(use_enable musicbrainz)
		$(use_with mtp)
		$(use_enable nsplugin browser-plugin)
		$(use_enable python)
		$(use_enable daap)
		$(use_with daap mdns avahi)
		--enable-mmkeys
		--disable-scrollkeeper
		--disable-schemas-install
		--disable-static
		--disable-vala"

	export GST_INSPECT=/bin/true
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_compile() {
	addpredict "$(unset HOME; echo ~)/.gconf"
	addpredict "$(unset HOME; echo ~)/.gconfd"
	gnome2_src_compile
}

src_test() {
	unset SESSION_MANAGER
	unset DBUS_SESSION_BUS_ADDRESS
	Xemake check || die "test failed"
}

pkg_postinst() {
	gnome2_pkg_postinst
	use python && python_mod_optimize /usr/$(get_libdir)/rhythmbox/plugins

	ewarn
	ewarn "If ${PN} doesn't play some music format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta"
	ewarn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/rhythmbox/plugins
}
