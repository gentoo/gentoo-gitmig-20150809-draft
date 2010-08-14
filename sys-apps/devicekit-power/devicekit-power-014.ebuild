# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devicekit-power/devicekit-power-014.ebuild,v 1.9 2010/08/14 17:11:06 armin76 Exp $

EAPI="2"
GCONF_DEBUG="no"

inherit eutils gnome2 linux-info

MY_PN="DeviceKit-power"

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DeviceKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE="debug doc test"

RDEPEND=">=dev-libs/glib-2.21.5
	>=dev-libs/dbus-glib-0.76
	>=sys-fs/udev-145[extras]
	>=sys-auth/polkit-0.91
	sys-apps/dbus
	virtual/libusb:0
"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	dev-libs/libxslt
	dev-util/gtk-doc-am
	doc? (
		>=dev-util/gtk-doc-1.3
		app-text/docbook-xml-dtd:4.1.2 )
	app-text/docbook-xsl-stylesheets
"
# docbook xsl is required for man pages
# FIXME: needs dbus-dtd currently only available with dbus[doc]

DOCS="AUTHORS HACKING NEWS"

S="${WORKDIR}/${MY_PN}-${PV}"

function check_battery() {
	# check sysfs power interface, bug #263959
	local CONFIG_CHECK="~ACPI_SYSFS_POWER"
	check_extra_config
}

pkg_setup() {
	# Pedantic is currently broken
	G2CONF="${G2CONF}
		--localstatedir=/var
		--disable-ansi
		--disable-static
		--enable-man-pages
		$(use_enable debug verbose-mode)
		$(use_enable test tests)
	"

	# ACPI is only availably on amd64/x86
	if use amd64 || use x86; then
		check_battery
	fi
}

src_prepare() {
	gnome2_src_prepare

	# Fix crazy cflags
	sed 's:-DG.*DISABLE_DEPRECATED::g' -i configure.ac configure \
		|| die "sed 1 failed"
	# Drop this command line option, because only available since gcc 4.3,
	# bug 289873.
	sed 's:WARNINGFLAGS_C=\"$WARNINGFLAGS_C -Wtype-limits\"::g' -i configure.ac configure \
		|| die "sed 2 failed"
}
