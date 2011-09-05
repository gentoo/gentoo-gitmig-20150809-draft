# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pk-helper/cups-pk-helper-0.1.3.ebuild,v 1.2 2011/09/05 19:55:47 maekke Exp $

EAPI="4"

DESCRIPTION="PolicyKit helper to configure cups with fine-grained privileges"
HOMEPAGE="http://cgit.freedesktop.org/cups-pk-helper/"
SRC_URI="http://www.freedesktop.org/software/${PN}/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=dev-libs/dbus-glib-0.74
	>=dev-libs/glib-2.14:2
	net-print/cups
	>=sys-apps/dbus-1.1.2
	>=sys-auth/polkit-0.92"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40.6
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	DOCS="AUTHORS HACKING NEWS README"
}
