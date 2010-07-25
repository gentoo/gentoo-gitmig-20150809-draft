# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/telepathy-mission-control/telepathy-mission-control-5.2.5.ebuild,v 1.6 2010/07/25 15:26:06 klausman Exp $

inherit eutils

DESCRIPTION="Telepathy Mission Control"
HOMEPAGE="http://telepathy.freedesktop.org"
SRC_URI="http://telepathy.freedesktop.org/releases/telepathy-mission-control/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="test"

RDEPEND=">=net-libs/telepathy-glib-0.7.32
	>=dev-libs/dbus-glib-0.51
	>=gnome-base/gconf-2"
#	gnome-keyring? ( >=gnome-base/gnome-keyring-2.22 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-libs/libxslt
	test? ( virtual/python
		dev-python/twisted-words )"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog
}
