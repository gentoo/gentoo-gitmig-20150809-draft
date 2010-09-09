# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/upower/upower-0.9.4.ebuild,v 1.7 2010/09/09 03:19:33 josejx Exp $

EAPI=3
inherit eutils linux-info

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://upower.freedesktop.org/"
SRC_URI="http://upower.freedesktop.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~x86-fbsd"
IUSE="debug doc nls introspection kernel_FreeBSD kernel_linux"

COMMON_DEPEND=">=dev-libs/glib-2.21.5:2
	>=sys-apps/dbus-1
	>=dev-libs/dbus-glib-0.76
	>=sys-auth/polkit-0.91
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? ( >=sys-fs/udev-151[extras]
		virtual/libusb:0 )
	!sys-apps/devicekit-power"
RDEPEND="${COMMON_DEPEND}
	kernel_linux? ( >=sys-power/pm-utils-1.3.0-r2 )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	doc? ( dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2 )
	nls? ( >=dev-util/intltool-0.40.0 )"

RESTRICT="test" # error getting system bus

pkg_setup() {
	if use kernel_linux; then
		if use amd64 || use x86; then
			CONFIG_CHECK="~ACPI_SYSFS_POWER"
			linux-info_pkg_setup
		fi
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-enumerate.patch

	sed -i \
		-e '/DISABLE_DEPRECATED/d' \
		configure || die
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
		--localstatedir="${EPREFIX}/var" \
		$(use_enable introspection) \
		--disable-dependency-tracking \
		--disable-static \
		$(use_enable debug verbose-mode) \
		--enable-man-pages \
		$(use_enable doc gtk-doc) \
		--disable-tests \
		$(use_enable nls) \
		--with-html-dir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--with-backend=${backend}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS HACKING NEWS README

	find "${ED}" -name '*.la' -delete
}
