# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-dvb-daemon/gnome-dvb-daemon-0.2.2.ebuild,v 1.5 2011/09/15 21:28:34 eva Exp $

EAPI="3"

inherit eutils python gnome2 multilib

DESCRIPTION="Setup your DVB devices, record and watch TV shows and browse EPG using GStreamer"
HOMEPAGE="http://live.gnome.org/DVBDaemon"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls totem vala"

RDEPEND=">=dev-libs/glib-2.28.5
	>=media-libs/gstreamer-0.10.29
	>=media-libs/gst-plugins-good-0.10.14
	>=media-libs/gst-plugins-bad-0.10.13
	>=dev-libs/libgee-0.5:0
	>=dev-db/sqlite-3.4
	>=media-libs/gst-rtsp-server-0.10.7
	media-plugins/gst-plugins-dvb
	>=dev-lang/python-2.5
	dev-python/gst-python
	>=dev-python/pygobject-2.28.4
	>=dev-libs/gobject-introspection-0.10.8
	|| ( sys-fs/udev[gudev] sys-fs/udev[extras] )
	vala? ( >=dev-lang/vala-0.12 )
	totem? ( media-video/totem )"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5.8.1
	>=dev-util/intltool-0.40.0
	>=dev-util/pkgconfig-0.9
	nls? ( >=sys-devel/gettext-0.18.1 )
	>=sys-devel/libtool-2.2.6"

pkg_setup() {
	G2CONF="${G2CONF} \
		$(use_enable nls)
		$(use_enable totem totem-plugin)"
	use totem && G2CONF="${G2CONF} \
		--with-totem-plugin-dir=/usr/$(get_libdir)/totem/plugins"
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	# Disable byte-compilation of Python modules.
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile || die

	gnome2_src_prepare
}

pkg_postinst() {
	python_mod_optimize gnomedvb
	if use totem; then
		python_mod_optimize "/usr/$(get_libdir)/totem/plugins"
	fi
	gnome2_pkg_postinst
}

pkg_postrm() {
	python_mod_cleanup gnomedvb
	if use totem; then
		python_mod_cleanup "/usr/$(get_libdir)/totem/plugins"
	fi
	gnome2_pkg_postrm
}
