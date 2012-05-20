# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/upower/upower-0.9.16.ebuild,v 1.5 2012/05/20 09:42:47 ago Exp $

EAPI=4

# PYTHON_DEPEND="test? 3"
# inherit python

inherit systemd

DESCRIPTION="D-Bus abstraction for enumerating power devices and querying history and statistics"
HOMEPAGE="http://upower.freedesktop.org/"
SRC_URI="http://upower.freedesktop.org/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug doc +introspection ios kernel_FreeBSD kernel_linux" # test

COMMON_DEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.22
	sys-apps/dbus
	>=sys-auth/polkit-0.104-r1
	introspection? ( dev-libs/gobject-introspection )
	kernel_linux? (
		|| ( >=sys-fs/udev-171-r5[gudev] <sys-fs/udev-171[extras] )
		virtual/libusb:1
		ios? (
			>=app-pda/libimobiledevice-1
			>=app-pda/libplist-1
			)
		)"
RDEPEND="${COMMON_DEPEND}
	kernel_linux? ( >=sys-power/pm-utils-1.4.1 )"
DEPEND="${COMMON_DEPEND}
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	dev-util/intltool
	virtual/pkgconfig
	doc? (
		dev-util/gtk-doc
		app-text/docbook-xml-dtd:4.1.2
		)"

DOCS=( AUTHORS HACKING NEWS README )

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
		$(use_with ios idevice) \
		"$(systemd_with_unitdir)"
}

src_install() {
	default
	keepdir /var/lib/upower #383091
	find "${ED}" -name '*.la' -exec rm -f {} +
}
