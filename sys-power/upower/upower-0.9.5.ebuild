# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/upower/upower-0.9.5.ebuild,v 1.4 2010/08/04 04:05:41 reavertm Exp $

EAPI=3

inherit linux-info base

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://upower.freedesktop.org/"
SRC_URI="http://upower.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86 ~x86-fbsd"
IUSE="debug doc introspection ipod kernel_FreeBSD kernel_linux nls"

COMMON_DEPEND="
	>=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.21.5:2
	>=sys-apps/dbus-1
	>=sys-auth/polkit-0.91
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? (
		>=sys-fs/udev-151[extras]
		virtual/libusb:1
		ipod? ( >=app-pda/libimobiledevice-0.9.7 )
	)
"
RDEPEND="${COMMON_DEPEND}
	!sys-apps/devicekit-power
	kernel_linux? ( >=sys-power/pm-utils-1.4.1 )
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig
"

RESTRICT="test" # error getting system bus

DOCS=(AUTHORS HACKING NEWS README)

pkg_setup() {
	if use kernel_linux; then
		if use amd64 || use x86; then
			CONFIG_CHECK="~ACPI_SYSFS_POWER"
			linux-info_pkg_setup
		fi
	fi
}

src_prepare() {
	base_src_prepare

	if ! use ipod; then
		sed -i -e 's:libimobiledevice:dIsAbLe&:' configure || die
	fi
}

src_configure() {
	local backend

	if use kernel_linux; then
		backend=linux
	elif use kernel_FreeBSD; then
		backend=freebsd
	else
		backend=dummy
	fi

	econf \
		--disable-gtk-doc \
		--disable-static \
		--disable-tests \
		--enable-man-pages \
		--localstatedir="${EPREFIX}/var" \
		--with-backend=${backend} \
		$(use_enable debug verbose-mode) \
		$(use_enable introspection) \
		$(use_enable nls)
}

src_install() {
	use doc && HTML_DOCS=("${S}/doc/html/")

	base_src_install

	find "${ED}" -name '*.la' -exec rm {} +
}
