# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-applets/gnome-applets-2.32.1.1.ebuild,v 1.2 2010/12/04 18:16:38 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.4"

inherit eutils gnome2 python

DESCRIPTION="Applets for the GNOME Desktop and Panel"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="battstat gnome gstreamer hal ipv6 networkmanager policykit"

# TODO: configure says python stuff is optional
# null applet still needs bonobo support for gnome-panel
HALDEPEND=" hal? ( >=sys-apps/hal-0.5.3 ) "
RDEPEND=">=x11-libs/gtk+-2.20:2
	>=dev-libs/glib-2.22:2
	>=gnome-base/gconf-2.8
	>=gnome-base/gnome-panel-2.31.2[bonobo]
	>=x11-libs/libxklavier-4.0
	>=x11-libs/libwnck-2.9.3
	>=gnome-base/gnome-desktop-2.11.1:2
	>=x11-libs/libnotify-0.3.2
	>=sys-apps/dbus-1.1.2
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libxml2-2.5.0
	>=x11-themes/gnome-icon-theme-2.15.91
	>=dev-libs/libgweather-2.22.1
	x11-libs/libX11

	battstat? ( $HALDEPEND )
	gnome?	(
		gnome-base/gnome-settings-daemon

		>=gnome-extra/gucharmap-2.23
		>=gnome-base/libgtop-2.11.92

		>=dev-python/pygobject-2.6
		>=dev-python/pygtk-2.6
		>=dev-python/libgnome-python-2.10
		>=dev-python/gconf-python-2.10
		>=dev-python/gnome-applets-python-2.10 )
	gstreamer?	(
		>=media-libs/gstreamer-0.10.2
		>=media-libs/gst-plugins-base-0.10.14
		|| (
			>=media-plugins/gst-plugins-alsa-0.10.14
			>=media-plugins/gst-plugins-oss-0.10.14 ) )
	networkmanager? ( >=net-misc/networkmanager-0.7.0 )
	policykit? ( >=sys-auth/polkit-0.92 )"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.1.4
	>=app-text/gnome-doc-utils-0.3.2
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35
	dev-libs/libxslt
	~app-text/docbook-xml-dtd-4.3"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS README"
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--disable-schemas-install
		$(use_enable gstreamer mixer-applet)
		$(use_enable ipv6)
		$(use_enable networkmanager)
		$(use_enable policykit polkit)"

	if use battstat; then
		G2CONF="${G2CONF} $(use_with hal)"
	else
		G2CONF="${G2CONF} --without-hal --disable-battstat"
	fi

	python_set_active_version 2
}

src_prepare() {
	gnome2_src_prepare

	# disable pyc compiling
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	# Invest applet tests need gconf/proxy/...
	sed 's/^TESTS.*/TESTS=/g' -i invest-applet/invest/Makefile.am \
		invest-applet/invest/Makefile.in || die "disabling invest tests failed"

	python_convert_shebangs -r 2 .
}

src_test() {
	unset DBUS_SESSION_BUS_ADDRESS
	emake check || die "emake check failed"
}

src_install() {
	gnome2_src_install

	local APPLETS="accessx-status battstat charpick cpufreq drivemount geyes
			 gkb-new gswitchit gweather invest-applet mini-commander
			 mixer modemlights multiload null_applet stickynotes trashapplet"

	# modemlights is out because it needs system-tools-backends-1

	for applet in ${APPLETS} ; do
		docinto ${applet}

		for d in AUTHORS ChangeLog NEWS README README.themes TODO ; do
			[ -s ${applet}/${d} ] && dodoc ${applet}/${d}
		done
	done
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use battstat && ! use hal ; then
		elog "It is highly recommended that you install acpid if you use the"
		elog "battstat applet to prevent any issues with other applications"
		elog "trying to read acpi information."
	fi

	# check for new python modules on bumps
	python_mod_optimize invest
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup invest
}
