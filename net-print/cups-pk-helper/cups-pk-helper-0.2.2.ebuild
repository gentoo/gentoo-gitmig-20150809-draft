# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pk-helper/cups-pk-helper-0.2.2.ebuild,v 1.2 2012/04/04 17:05:09 tetromino Exp $

EAPI="4"

DESCRIPTION="PolicyKit helper to configure cups with fine-grained privileges"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/cups-pk-helper"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

# Require {glib,gdbus-codegen}-2.30.0 due to GDBus changes between 2.29.92
# and 2.30.0
COMMON_DEPEND=">=dev-libs/glib-2.30.0:2
	net-print/cups
	>=sys-auth/polkit-0.97"
RDEPEND="${COMMON_DEPEND}
	sys-apps/dbus"
DEPEND="${COMMON_DEPEND}
	app-arch/xz-utils
	>=dev-util/gdbus-codegen-2.30.0
	>=dev-util/intltool-0.40.6
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	DOCS="AUTHORS HACKING NEWS README"

	# Regenerate dbus-codegen files to fix build with glib-2.30.x; bug #410773
	rm -v src/cph-iface-mechanism.{c,h} || die
}
