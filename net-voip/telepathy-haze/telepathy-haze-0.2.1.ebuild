# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-haze/telepathy-haze-0.2.1.ebuild,v 1.3 2009/01/07 17:10:46 armin76 Exp $

inherit eutils

DESCRIPTION="Telepathy connection manager providing libpurple supported
protocols."
HOMEPAGE="http://developer.pidgin.im/wiki/Telepathy"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND="net-im/pidgin
	>=net-libs/telepathy-glib-0.7.0
	>=dev-libs/glib-2
	dev-libs/dbus-glib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS NEWS README
}
