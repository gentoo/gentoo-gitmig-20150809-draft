# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devicekit/devicekit-003.ebuild,v 1.3 2010/04/11 18:18:35 armin76 Exp $

EAPI="1"
GCONF_DEBUG="no"

inherit gnome2

MY_PN="DeviceKit"

DESCRIPTION="D-Bus abstraction for enumerating devices and listening for device events using udev"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/DeviceKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.12
	>=dev-libs/dbus-glib-0.76
	>=sys-fs/udev-130
"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd:4.1.2
	doc? ( >=dev-util/gtk-doc-1.3 )
"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-static
		--localstatedir=/var
		--enable-ansi
		--enable-man-pages"
}
