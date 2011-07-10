# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/upower/upower-0.9.12.ebuild,v 1.2 2011/07/10 16:11:39 hwoarang Exp $

EAPI=4
inherit linux-info

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://upower.freedesktop.org/"
SRC_URI="http://upower.freedesktop.org/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc +introspection ios kernel_FreeBSD kernel_linux"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.88
	>=dev-libs/glib-2.21.5:2
	sys-apps/dbus
	>=sys-auth/polkit-0.101-r1
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? (
		|| ( >=sys-fs/udev-171[gudev] >=sys-fs/udev-151[extras] )
		virtual/libusb:1
		ios? ( >=app-pda/libimobiledevice-0.9.7
			>=app-pda/libplist-0.12 ) )
	!sys-apps/hal"
RDEPEND="${COMMON_DEPEND}
	kernel_linux? ( >=sys-power/pm-utils-1.4.1 )"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	>=dev-util/intltool-0.40.0
	dev-util/pkgconfig
	doc? ( dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2 )"

RESTRICT="test"

DOCS=( AUTHORS HACKING NEWS README )

pkg_setup() {
	if use kernel_linux && kernel_is lt 2 6 37; then
		if use amd64 || use x86; then
			CONFIG_CHECK="~ACPI_SYSFS_POWER"
			linux-info_pkg_setup
		fi
	fi
}

src_prepare() {
	sed -i -e '/DISABLE_DEPRECATED/d' configure || die
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
		--localstatedir="${EPREFIX}"/var \
		$(use_enable introspection) \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		--disable-tests \
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--with-backend=${backend} \
		$(use_with ios idevice)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
