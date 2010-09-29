# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-mission-control/telepathy-mission-control-5.6.0.ebuild,v 1.2 2010/09/29 19:30:56 mr_bones_ Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Telepathy Mission Control"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/telepathy-mission-control/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gnome-keyring test"

RDEPEND=">=net-libs/telepathy-glib-0.11.9
	>=dev-libs/dbus-glib-0.82
	>=gnome-base/gconf-2
	gnome-keyring? ( || ( gnome-base/libgnome-keyring <gnome-base/gnome-keyring-2.29.4 ) )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	test? ( >=virtual/python-2.5
		dev-python/twisted-words )"

# Tests are broken, see upstream bug #29334
RESTRICT="test"

src_configure() {
	# creds is not available and no support mcd-plugins for now
	econf	$(use_enable gnome-keyring) \
		--disable-mcd-plugins
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog || die
}
