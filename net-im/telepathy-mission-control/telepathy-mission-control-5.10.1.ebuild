# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-mission-control/telepathy-mission-control-5.10.1.ebuild,v 1.1 2011/11/13 09:52:18 tetromino Exp $

EAPI="4"
PYTHON_DEPEND="2:2.5"

inherit python

DESCRIPTION="An account manager and channel dispatcher for the Telepathy framework."
HOMEPAGE="http://telepathy.freedesktop.org/wiki/Mission%20Control"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-linux"
IUSE="gnome-keyring networkmanager +upower"
# IUSE="test"

# Fixme: connman support
RDEPEND=">=net-libs/telepathy-glib-0.13.14
	>=dev-libs/dbus-glib-0.82
	gnome-keyring? ( gnome-base/libgnome-keyring )
	networkmanager? ( >=net-misc/networkmanager-0.7 )
	upower? ( sys-power/upower )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt"
#	test? ( dev-python/twisted-words )"

# Tests are broken, see upstream bug #29334
# upstream doesn't want it enabled everywhere
RESTRICT="test"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

src_configure() {
	# creds is not available and no support mcd-plugins for now
	econf --disable-static\
		--disable-mcd-plugins \
		--disable-schemas-compile \
		$(use_enable gnome-keyring) \
		$(use_with networkmanager connectivity nm) \
		$(use_enable upower)
}

src_install() {
	default

	find "${ED}" -name '*.la' -exec rm -f '{}' + || die
}
